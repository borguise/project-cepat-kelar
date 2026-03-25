<#-- Variabel ini biasanya dikirim dari Java Controller, misal: model.addAttribute("activePage", "artikel") -->
<#assign activePage = "artikel">
<#import "/layout/backoffice_layout.ftl" as layout>

<@layout.backofficeLayout title="Admin - Editor Artikel Literasi" activePage=activePage adminName=adminName>

  <div class="w-full max-w-5xl mx-auto">
        <h2 class="text-3xl font-bold mb-8 font-gelasio text-slate-800">
            <#if artikel??>Edit Artikel<#else>Tambah Artikel Baru</#if>
        </h2>
        
        <#-- Flash Messages -->
        <#if successMessage??>
          <div class="mb-6 bg-green-100 border border-green-400 text-green-700 px-6 py-4 rounded-xl" role="alert">
            <span class="block sm:inline">${successMessage}</span>
          </div>
        </#if>
        <#if errorMessage??>
          <div class="mb-6 bg-red-100 border border-red-400 text-red-700 px-6 py-4 rounded-xl" role="alert">
            <span class="block sm:inline">${errorMessage}</span>
          </div>
        </#if>
        
        <#if !artikel??>
        <!-- Auto-save Status Indicator -->
        <div id="autosave-status" class="mb-4 px-4 py-3 rounded-lg text-center text-sm font-medium transition-all opacity-0">
          <span id="autosave-text"></span>
        </div>
        </#if>
        
          <form id="article-form" action="/admin/articles/save" method="POST" enctype="multipart/form-data" 
            class="w-full bg-white p-12 rounded-2xl shadow-[0px_4px_10px_rgba(0,0,0,0.05)] space-y-10 border border-stone-100">
          
          <#if artikel??><input type="hidden" id="article-id" name="id" value="${artikel.id?c}"><#else><input type="hidden" id="article-id" name="id" value=""></#if>

          <div class="space-y-3">
              <label class="block text-2xl font-gelasio text-black">Judul</label>
              <input type="text" id="judul-input" name="title" value="${(artikel.title)!''}" placeholder="Tulis Judul disini" required
                     class="w-full h-12 border border-gray-200 rounded-lg outline-none px-6 text-[#4338ca] text-xl font-['Lato'] focus:ring-2 focus:ring-indigo-500 transition">
          </div>

          <div class="space-y-3">
              <label class="block text-2xl font-gelasio text-black">Kategori</label>
              <input type="text" id="kategori-input" name="category" value="${(artikel.category)!''}" placeholder="Kategori konten" required
                     class="w-full h-12 border border-gray-200 rounded-lg outline-none px-6 text-[#4338ca] text-xl font-gelasio focus:ring-2 focus:ring-indigo-500 transition">
          </div>

          <div class="space-y-3">
              <label class="block text-2xl font-gelasio text-black">Gambar Sampul</label>
              <label for="upload-file" class="w-full h-40 border-2 border-dashed border-gray-200 rounded-lg flex items-center justify-center cursor-pointer hover:bg-gray-50 transition relative overflow-hidden group">
                  <#-- Show image from database BLOB if available -->
                  <#if artikel?? && artikel.id?? && artikel.coverImage?? && artikel.coverImage?has_content>
                    <img id="preview" src="/admin/articles/image/${artikel.id?c}" 
                         class="absolute inset-0 w-full h-full object-cover"
                         onerror="this.classList.add('hidden'); document.getElementById('label-text').classList.remove('opacity-0');">
                    <span id="label-text" class="text-indigo-400 group-hover:text-indigo-600 font-['Lato'] opacity-0">
                      Klik untuk upload gambar
                    </span>
                  <#else>
                    <img id="preview" src="#" class="hidden absolute inset-0 w-full h-full object-cover">
                    <span id="label-text" class="text-indigo-400 group-hover:text-indigo-600 font-['Lato']">
                      Klik untuk upload gambar
                    </span>
                  </#if>
                  <input type="file" id="upload-file" name="cover" class="hidden" onchange="previewImage(event)">
              </label>
          </div>

          <div class="space-y-3">
              <label class="block text-2xl font-gelasio text-black">Isi Konten</label>
              <textarea id="isi-input" name="content" rows="10" placeholder="Mulai menulis artikel Anda..." 
                        class="w-full p-8 border border-gray-200 rounded-lg outline-none text-[#4338ca] text-xl font-['Lato'] focus:ring-2 focus:ring-indigo-500 resize-none leading-relaxed">${(artikel.content)!''}</textarea>
          </div>

           <div class="flex justify-center gap-4 pt-4 flex-wrap">
              <#if artikel??>
              <button type="submit" name="statusAction" value="KEEP" class="bg-indigo-600 hover:bg-indigo-700 text-white px-10 py-4 rounded-xl shadow-md transition-all font-bold text-xl font-['Lato'] transform hover:-translate-y-1">
                Simpan Perubahan
              </button>
              </#if>
              <#if !artikel?? || !artikel.status?? || artikel.status?string != "PUBLISHED">
              <button type="submit" name="statusAction" value="PUBLISHED" class="bg-[#bef264] hover:bg-[#a3e635] text-slate-800 px-10 py-4 rounded-xl shadow-md transition-all font-bold text-xl font-['Lato'] transform hover:-translate-y-1">
                Publikasikan
              </button>
              </#if>
              <#if !artikel?? || !artikel.status?? || artikel.status?string != "HIDDEN">
              <button type="submit" name="statusAction" value="HIDDEN" class="bg-slate-300 hover:bg-slate-400 text-slate-800 px-10 py-4 rounded-xl shadow-md transition-all font-bold text-xl font-['Lato'] transform hover:-translate-y-1">
                Sembunyikan
              </button>
              </#if>
          </div>
        </form>
    </div>

  <script>
    function previewImage(event) {
        const reader = new FileReader();
        reader.onload = function() {
            const preview = document.getElementById('preview');
            const labelText = document.getElementById('label-text');
            preview.src = reader.result;
            preview.classList.remove('hidden');
            labelText.classList.add('opacity-0');
        }
        reader.readAsDataURL(event.target.files[0]);
    }

      <#if !artikel??>
    
    // Auto-save functionality
    let autoSaveTimeout;
    let isSaving = false;
    let isSubmitting = false;
    
    const judulInput = document.getElementById('judul-input');
    const kategoriInput = document.getElementById('kategori-input');
    const isiInput = document.getElementById('isi-input');
    const articleIdInput = document.getElementById('article-id');
    const statusDiv = document.getElementById('autosave-status');
    const statusText = document.getElementById('autosave-text');
    const articleForm = document.getElementById('article-form');
    const submitButtons = articleForm.querySelectorAll('button[type="submit"]');
    
    function showStatus(message, type) {
        let colorClass = type === 'saving' ? 'bg-blue-100 text-blue-700' :
                        type === 'success' ? 'bg-green-100 text-green-700' :
                        type === 'error' ? 'bg-red-100 text-red-700' : '';
        statusDiv.className = 'mb-4 px-4 py-3 rounded-lg text-center text-sm font-medium transition-all opacity-100 ' + colorClass;
        statusText.textContent = message;
        
        if (type === 'success') {
            setTimeout(() => {
                statusDiv.classList.add('opacity-0');
            }, 3000);
        }
    }
    
    function autoSave() {
      if (isSaving || isSubmitting) return;
        
        const judul = judulInput.value.trim();
        const kategori = kategoriInput.value.trim();
        const isi = isiInput.value.trim();
        const articleId = articleIdInput.value;
        
        // Skip if all fields are empty
        if (!judul && !kategori && !isi) {
            return;
        }
        
        isSaving = true;
        showStatus('Menyimpan draft...', 'saving');
        
        const formData = new FormData();
        if (articleId) formData.append('id', articleId);
        if (judul) formData.append('title', judul);
        if (kategori) formData.append('category', kategori);
        if (isi) formData.append('content', isi);
        
        fetch('/admin/articles/autosave', {
            method: 'POST',
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            isSaving = false;
            if (data.success) {
                // Update article ID if it was a new article
                if (data.articleId && !articleIdInput.value) {
                    articleIdInput.value = data.articleId;
                }
                
                const now = new Date();
                const timeStr = now.toLocaleTimeString('id-ID', { hour: '2-digit', minute: '2-digit' });
                showStatus('✓ Draft tersimpan otomatis pada ' + timeStr, 'success');
            } else {
                showStatus('⚠ Gagal menyimpan: ' + (data.message || 'Unknown error'), 'error');
            }
        })
        .catch(error => {
            isSaving = false;
            console.error('Auto-save error:', error);
            showStatus('⚠ Gagal menyimpan draft', 'error');
        });
    }
    
    function scheduleAutoSave() {
      if (isSubmitting) return;
        clearTimeout(autoSaveTimeout);
        autoSaveTimeout = setTimeout(autoSave, 2000); // Auto-save after 2 seconds of inactivity
    }

    function lockSubmittingState() {
      isSubmitting = true;
      clearTimeout(autoSaveTimeout);
    }

    submitButtons.forEach(function(btn) {
      btn.addEventListener('mousedown', lockSubmittingState);
      btn.addEventListener('touchstart', lockSubmittingState);
      btn.addEventListener('keydown', function(e) {
        if (e.key === 'Enter' || e.key === ' ') {
          lockSubmittingState();
        }
      });
    });

    articleForm.addEventListener('submit', lockSubmittingState);
    
    // Attach event listeners
    judulInput.addEventListener('input', scheduleAutoSave);
    kategoriInput.addEventListener('input', scheduleAutoSave);
    isiInput.addEventListener('input', scheduleAutoSave);
    
    // Also save when user stops typing in textarea
    isiInput.addEventListener('blur', function() {
        clearTimeout(autoSaveTimeout);
      if (!isSaving && !isSubmitting) {
            autoSave();
        }
    });
    </#if>
  </script>

</@layout.backofficeLayout>
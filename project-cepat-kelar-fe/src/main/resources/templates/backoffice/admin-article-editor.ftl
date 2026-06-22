<#assign activePage = "artikel">
<#import "/layout/backoffice_layout.ftl" as layout>

<@layout.backofficeLayout title="Admin - Editor Artikel Literasi" activePage=activePage adminName=adminName>

  <div class="w-full max-w-4xl mx-auto px-4 mb-20">
        <h2 class="text-2xl font-bold mb-4 font-gelasio text-slate-800">
            <#if artikel??>Edit Artikel<#else>Tambah Artikel Baru</#if>
        </h2>
        
        <#-- Flash Messages -->
        <#if successMessage??>
          <div class="mb-4 bg-green-100 border border-green-400 text-green-700 px-6 py-4 rounded-xl" role="alert">
            <span class="block sm:inline">${successMessage}</span>
          </div>
        </#if>
        <#if errorMessage??>
          <div class="mb-4 bg-red-100 border border-red-400 text-red-700 px-6 py-4 rounded-xl" role="alert">
            <span class="block sm:inline">${errorMessage}</span>
          </div>
        </#if>
        
        <#if !artikel??>
        <div id="autosave-status" class="mb-2 px-4 py-2 rounded-lg text-center text-sm font-medium transition-all opacity-0">
          <span id="autosave-text"></span>
        </div>
        </#if>
        
          <form id="article-form" action="/admin/articles/save" method="POST" enctype="multipart/form-data" 
            class="w-full bg-white px-10 pt-8 pb-12 rounded-xl shadow-[0px_2px_15px_rgba(0,0,0,0.03)] space-y-8 border border-slate-50">
          
          <#if artikel??><input type="hidden" id="article-id" name="id" value="${artikel.id?c}"><#else><input type="hidden" id="article-id" name="id" value=""></#if>

          <div class="space-y-3">
              <label class="block text-lg font-gelasio text-slate-800">Judul</label>
              <input type="text" id="judul-input" name="title" value="${(artikel.title)!''}" placeholder="Tulis Judul disini" required
                     class="w-full h-12 border border-slate-200 rounded-lg outline-none px-6 text-[#4338ca] text-center placeholder:text-[#4338ca] text-base font-lato focus:ring-2 focus:ring-indigo-100 transition">
          </div>

          <div class="space-y-3">
              <label class="block text-lg font-gelasio text-slate-800">Kategori</label>
              <input type="text" id="kategori-input" name="category" value="${(artikel.category)!''}" placeholder="Kategori konten" required
                     class="w-full h-12 border border-slate-200 rounded-lg outline-none px-6 text-[#4338ca] text-center placeholder:text-[#4338ca] text-base font-lato focus:ring-2 focus:ring-indigo-100 transition">
          </div>

          <div class="space-y-3">
              <label class="block text-lg font-gelasio text-slate-800">Gambar Sampul</label>
              <label for="upload-file" class="w-full h-32 border border-dashed border-slate-300 rounded-lg flex items-center justify-center cursor-pointer hover:bg-slate-50 transition relative overflow-hidden group">
                  <#if artikel?? && artikel.id?? && artikel.coverImage?? && artikel.coverImage?has_content>
                    <img id="preview" src="/admin/articles/image/${artikel.id?c}" 
                         class="absolute inset-0 w-full h-full object-cover"
                         onerror="this.classList.add('hidden'); document.getElementById('label-text').classList.remove('opacity-0');">
                    <span id="label-text" class="text-[#4338ca] text-sm font-lato opacity-0 transition-opacity">
                      Klik untuk upload gambar
                    </span>
                  <#else>
                    <img id="preview" src="#" class="hidden absolute inset-0 w-full h-full object-cover">
                    <span id="label-text" class="text-[#4338ca] text-sm font-lato">
                      Klik untuk upload gambar
                    </span>
                  </#if>
                  <input type="file" id="upload-file" name="cover" class="hidden" onchange="previewImage(event)" accept="image/*">
              </label>
          </div>

          <div class="space-y-3">
              <label class="block text-lg font-gelasio text-slate-800">Isi Konten</label>
              <textarea id="isi-input" name="content" placeholder="Isi Artikel" 
                        class="w-full h-64 px-6 pt-28 pb-6 border border-slate-200 rounded-lg outline-none text-[#4338ca] text-center placeholder:text-[#4338ca] text-base font-lato focus:ring-2 focus:ring-indigo-100 resize-none leading-relaxed overflow-y-auto">${(artikel.content)!''}</textarea>
          </div>

           <div class="flex justify-center pt-8">
              <#if artikel??>
              <button type="submit" name="statusAction" value="KEEP" class="bg-[#4338ca] hover:bg-indigo-700 text-white px-14 py-4 rounded-xl shadow-md hover:shadow-lg transition-all duration-300 font-bold text-base font-lato active:scale-95">
                Simpan Perubahan
              </button>
              <#else>
              <button type="submit" name="statusAction" value="PUBLISHED" class="bg-[#bef264] hover:bg-[#a3e635] text-indigo-950 px-16 py-4 rounded-xl shadow-md hover:shadow-lg transition-all duration-300 font-bold text-base font-lato active:scale-95">
                Publikasikan
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
        if(event.target.files[0]) {
            reader.readAsDataURL(event.target.files[0]);
        }
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
        let colorClass = type === 'saving' ? 'bg-indigo-50 text-indigo-600' :
                        type === 'success' ? 'bg-green-50 text-green-600' :
                        type === 'error' ? 'bg-red-50 text-red-600' : '';
        statusDiv.className = 'mb-2 px-4 py-2 rounded-lg text-center text-xs font-lato transition-all opacity-100 ' + colorClass;
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
                if (data.articleId && !articleIdInput.value) {
                    articleIdInput.value = data.articleId;
                }
                const now = new Date();
                const timeStr = now.toLocaleTimeString('id-ID', { hour: '2-digit', minute: '2-digit' });
                showStatus('Draft tersimpan otomatis (' + timeStr + ')', 'success');
            } else {
                showStatus('Gagal menyimpan: ' + (data.message || 'Unknown error'), 'error');
            }
        })
        .catch(error => {
            isSaving = false;
            console.error('Auto-save error:', error);
            showStatus('Gagal menyimpan draft', 'error');
        });
    }
    
    function scheduleAutoSave() {
      if (isSubmitting) return;
        clearTimeout(autoSaveTimeout);
        autoSaveTimeout = setTimeout(autoSave, 2000); 
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
    
    judulInput.addEventListener('input', scheduleAutoSave);
    kategoriInput.addEventListener('input', scheduleAutoSave);
    isiInput.addEventListener('input', scheduleAutoSave);
    
    isiInput.addEventListener('blur', function() {
        clearTimeout(autoSaveTimeout);
      if (!isSaving && !isSubmitting) {
            autoSave();
        }
    });
    </#if>
  </script>

</@layout.backofficeLayout>
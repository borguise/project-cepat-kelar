<#-- 1. Penanda Halaman Aktif untuk Sidebar -->
<#assign activePage = "artikel">
<#import "/layout/backoffice_layout.ftl" as layout>

<@layout.backofficeLayout title="Admin - Daftar Artikel & Berita" activePage=activePage adminName=adminName>
      
      <#-- Flash Messages -->
      <#if successMessage??>
        <div class="max-w-6xl w-full mx-auto px-4">
          <div class="bg-green-100 border border-green-400 text-green-700 px-6 py-4 rounded-xl relative" role="alert">
            <span class="block sm:inline">${successMessage}</span>
          </div>
        </div>
      </#if>
      <#if errorMessage??>
        <div class="max-w-6xl w-full mx-auto px-4">
          <div class="bg-red-100 border border-red-400 text-red-700 px-6 py-4 rounded-xl relative" role="alert">
            <span class="block sm:inline">${errorMessage}</span>
          </div>
        </div>
      </#if>
      
      <div class="flex justify-between items-end max-w-6xl w-full mx-auto px-4">
        <h2 class="text-3xl font-bold font-gelasio text-black italic">Daftar Artikel & Berita</h2>
        <a href="/admin/articles/new" class="h-12 bg-[#bef264] text-indigo-900 px-8 flex items-center justify-center rounded-xl shadow-md font-bold text-base hover:bg-lime-400 transition-all active:scale-95 whitespace-nowrap">
          + Tambah Artikel Baru
        </a>
      </div>

      <div class="w-full max-w-3xl mx-auto">
        <form method="GET" action="/admin/articles" class="flex flex-col gap-4">
          <input type="hidden" name="searchType" value="all">
          
          <!-- Search Input -->
          <div class="relative">
            <input type="text" name="search" id="searchInput" 
                   placeholder="Ketik judul atau kategori untuk mencari..." 
                   value="<#if searchText??>${searchText}</#if>"
                   class="w-full py-4 px-10 bg-white rounded-xl shadow-[0px_4px_15px_rgba(0,0,0,0.1)] border border-stone-100 outline-none font-gelasio text-2xl text-center focus:ring-2 focus:ring-indigo-100">
            <#if searchText??>
              <a href="/admin/articles" class="absolute right-4 top-1/2 transform -translate-y-1/2 text-gray-400 hover:text-gray-600 text-2xl" title="Clear search">×</a>
            </#if>
          </div>
        </form>
      </div>

      <div class="w-full max-w-6xl mx-auto bg-white rounded-3xl shadow-[0px_10px_30px_rgba(243,237,237,1.0)] border border-stone-100 overflow-hidden mb-20">
        <table class="w-full text-center border-collapse">
          <thead>
            <tr class="font-gelasio text-black text-xl border-b border-black">
              <th class="px-8 py-8 border-r border-black/10 w-[35%] font-bold">Judul Artikel</th>
              <th class="px-8 py-8 border-r border-black/10 font-bold">Kategori</th>
              <th class="px-6 py-8 border-r border-black/10 font-bold w-44">Status</th>
              <th class="px-8 py-8 border-r border-black/10 font-bold">Tanggal</th>
              <th class="px-6 py-8 font-bold">Aksi</th>
            </tr>
          </thead>
          <tbody class="font-['Lato'] text-black text-lg divide-y divide-black/10">
            
            <#-- LOGIKA LOOPING: Mengulang baris secara otomatis sesuai data database -->
            <#if articles?? && articles?size gt 0>
              <#list articles as art>
                <tr class="h-28 hover:bg-slate-50 transition">
                  <td class="px-10 border-r border-black/10 text-center">${art.title!''}</td>
                  <td class="px-4 border-r border-black/10 text-blue-600 font-bold">${art.category!''}</td>
                  <td class="px-4 border-r border-black/10">
                    <#assign statusLabel = "Draft">
                    <#assign statusClass = "bg-amber-100 text-amber-700">
                    <#if art.status??>
                      <#if art.status?string == "PUBLISHED">
                        <#assign statusLabel = "Terbit">
                        <#assign statusClass = "bg-green-100 text-green-700">
                      <#elseif art.status?string == "DRAFT">
                        <#assign statusLabel = "Draft">
                        <#assign statusClass = "bg-amber-100 text-amber-700">
                      <#elseif art.status?string == "HIDDEN">
                        <#assign statusLabel = "Tersembunyi">
                        <#assign statusClass = "bg-slate-200 text-slate-700">
                      <#elseif art.status?string == "ARCHIVED">
                        <#assign statusLabel = "Arsip">
                        <#assign statusClass = "bg-indigo-100 text-indigo-700">
                      </#if>
                    </#if>
                    <span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-bold ${statusClass}">${statusLabel}</span>
                  </td>
                  <td class="px-4 border-r border-black/10 font-bold">
                    <#if art.publishDate??>
                      ${art.publishDate?string('dd/MM/yyyy')}
                    <#else>
                      ${art.createdDate?string('dd/MM/yyyy')}
                    </#if>
                  </td>
                  <td class="px-4">
                    <div class="flex justify-center gap-6 items-center">
                      <#-- LINK DINAMIS: Mengirim ID unik ke halaman editor -->
                      <a href="/admin/articles/edit/${art.id?c}" title="Edit" class="w-12 h-12 bg-indigo-600 text-white rounded-xl flex items-center justify-center shadow hover:bg-indigo-800 transition">
                        ✏️
                      </a>
                      <button onclick="confirmDelete(${art.id?c})" title="Delete" class="w-12 h-12 bg-slate-400 text-white rounded-xl flex items-center justify-center shadow hover:bg-red-600 transition">
                        🗑️
                      </button>
                    </div>
                  </td>
                </tr>
              </#list>
            <#else>
              <tr>
                <td colspan="5" class="py-20 text-center italic text-stone-400">Belum ada artikel yang tersedia.</td>
              </tr>
            </#if>

          </tbody>
        </table>

        <div class="px-12 py-8 bg-slate-50 border-t border-black/10 flex justify-between items-center text-slate-500">
            <span>
              <#if searchText??>
                Menampilkan <#if articles??>${articles?size}<#else>0</#if> hasil pencarian berdasarkan <strong>judul & kategori</strong>
                "<strong>${searchText}</strong>"
              <#else>
                Menampilkan <#if articles??>${articles?size}<#else>0</#if> Artikel
              </#if>
            </span>
            <div class="flex gap-4 items-center">
                <#-- Logika paginasi sederhana -->
                <button class="hover:text-indigo-600 font-bold">« Sebelumnya</button>
                <div class="flex gap-2">
                    <span class="w-10 h-10 flex items-center justify-center bg-indigo-600 text-white rounded-lg cursor-pointer">1</span>
                    <span class="w-10 h-10 flex items-center justify-center hover:bg-indigo-100 rounded-lg cursor-pointer transition">2</span>
                </div>
                <button class="hover:text-indigo-600 font-bold">Selanjutnya »</button>
            </div>
        </div>
      </div>

    </div>
  </main>

  <script>
    function confirmDelete(id) {
        if(confirm("Apakah Anda yakin ingin menghapus artikel ini?")) {
            window.location.href = "/admin/articles/delete/" + id;
        }
    }
    
    // Auto-submit search on input with debouncing
    let searchTimeout;
    const searchInput = document.getElementById('searchInput');
    const searchForm = searchInput.form;
    
    // Auto-submit on input with debouncing
    searchInput.addEventListener('input', function(e) {
        clearTimeout(searchTimeout);
        searchTimeout = setTimeout(function() {
            if (e.target.value.length >= 3 || e.target.value.length === 0) {
                searchForm.submit();
            }
        }, 500); // Wait 500ms after user stops typing
    });
    
    // Submit on Enter key
    searchInput.addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            e.preventDefault();
            clearTimeout(searchTimeout);
            searchForm.submit();
        }
    });
  </script>

</@layout.backofficeLayout>
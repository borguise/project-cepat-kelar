<#-- 1. Penanda Halaman Aktif untuk Sidebar -->
<#assign activePage = "artikel">
<#import "/layout/backoffice_layout.ftl" as layout>

<@layout.backofficeLayout title="Admin - Daftar Artikel & Berita" activePage=activePage adminName=adminName>
    
    <div class="w-full">
      
      <#-- Flash Messages -->
      <#if successMessage??>
        <div class="max-w-5xl w-full mx-auto px-4 mb-4">
          <div class="bg-green-100 border border-green-400 text-green-700 px-6 py-4 rounded-xl relative" role="alert">
            <span class="block sm:inline">${successMessage}</span>
          </div>
        </div>
      </#if>
      <#if errorMessage??>
        <div class="max-w-5xl w-full mx-auto px-4 mb-4">
          <div class="bg-red-100 border border-red-400 text-red-700 px-6 py-4 rounded-xl relative" role="alert">
            <span class="block sm:inline">${errorMessage}</span>
          </div>
        </div>
      </#if>
      
      <div class="w-full max-w-5xl mx-auto px-4 mb-8">
        <h2 class="text-xl font-bold font-gelasio text-black">Daftar Artikel & Berita</h2>
      </div>

      <div class="w-full max-w-5xl mx-auto px-4 mb-10 flex flex-col md:flex-row justify-between items-center gap-6">
        
        <form method="GET" action="/admin/articles" class="w-full md:w-2/3 relative">
          <input type="hidden" name="searchType" value="all">
          
          <input type="text" name="search" id="searchInput" 
                 placeholder="Ketik Judul atau Kategori disini" 
                 value="<#if searchText??>${searchText}</#if>"
                 class="w-full py-4 px-6 pr-20 bg-white rounded-xl shadow-[0px_2px_10px_rgba(0,0,0,0.05)] border border-slate-100 outline-none font-lato text-center focus:ring-2 focus:ring-indigo-100">
          
          <div class="absolute right-5 top-1/2 transform -translate-y-1/2 flex items-center gap-3">
            <#-- Tombol Silang (X) muncul HANYA jika sedang melakukan pencarian -->
            <#if searchText?? && searchText != "">
              <a href="/admin/articles" class="text-red-400 hover:text-red-600 hover:scale-110 transition bg-red-50 p-1.5 rounded-full" title="Batalkan Pencarian">
                <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                  <line x1="18" y1="6" x2="6" y2="18"></line>
                  <line x1="6" y1="6" x2="18" y2="18"></line>
                </svg>
              </a>
            </#if>
            
            <#-- Tombol Kaca Pembesar (Submit) -->
            <button type="submit" class="text-black hover:scale-110 transition">
              <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <circle cx="11" cy="11" r="8"></circle>
                <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
              </svg>
            </button>
          </div>
        </form>

        <a href="/admin/articles/new" class="bg-[#bef264] text-black px-8 py-4 flex items-center justify-center rounded-xl shadow-sm font-lato font-semibold text-sm hover:bg-lime-400 transition-all active:scale-95 whitespace-nowrap">
          + Tambah Artikel Baru
        </a>
      </div>

      <div class="w-full max-w-5xl mx-auto px-4 mb-20">
        <div class="w-full overflow-x-auto bg-white rounded-t-2xl shadow-[0px_5px_20px_rgba(243,237,237,1.0)] border border-stone-100">
          <table class="w-full text-center border-collapse min-w-[900px]">
            <thead>
              <tr class="font-lato text-black text-sm border-b border-black">
                <th class="px-6 py-6 border-r border-black/20 w-[30%] font-semibold text-center">Judul Artikel</th>
                <th class="px-4 py-6 border-r border-black/20 font-semibold w-[15%]">Kategori</th>
                <th class="px-4 py-6 border-r border-black/20 font-semibold w-[15%]">Status</th>
                <th class="px-4 py-6 border-r border-black/20 font-semibold w-[15%]">Tanggal</th>
                <th class="px-4 py-6 font-semibold w-[25%]">Aksi</th>
              </tr>
            </thead>
            <tbody class="font-lato text-black text-sm divide-y divide-transparent">
              
              <#if articles?? && articles?size gt 0>
                <#list articles as art>
                  <tr class="h-24 hover:bg-slate-50 transition border-b border-black/5 last:border-b-0">
                    <td class="px-6 border-r border-black/20 text-center font-medium">${art.title!''}</td>
                    <td class="px-4 border-r border-black/20 text-center text-slate-600">${art.category!''}</td>
                    
                    <td class="px-4 border-r border-black/20 text-center">
                      <#assign statusLabel = "Draft">
                      <#assign statusClass = "bg-slate-100 text-slate-600 border-slate-200">
                      
                      <#if art.status??>
                        <#if art.status?string == "PUBLISHED">
                          <#assign statusLabel = "Terbit">
                          <#assign statusClass = "bg-green-50 text-green-700 border-green-200">
                        <#elseif art.status?string == "DRAFT">
                          <#assign statusLabel = "Draft">
                          <#assign statusClass = "bg-amber-50 text-amber-700 border-amber-200">
                        <#elseif art.status?string == "HIDDEN">
                          <#assign statusLabel = "Disembunyikan">
                          <#assign statusClass = "bg-slate-100 text-slate-600 border-slate-200">
                        </#if>
                      </#if>
                      
                      <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-bold border ${statusClass}">
                        ${statusLabel}
                      </span>
                    </td>

                    <td class="px-4 border-r border-black/20 text-center text-slate-600">
                      <#if art.publishDate??>
                        ${art.publishDate?string('dd/MM/yyyy')}
                      <#else>
                        ${art.createdDate?string('dd/MM/yyyy')}
                      </#if>
                    </td>
                    <td class="px-4">
                      <div class="flex justify-center gap-4 items-center">
                        
                        <a href="/admin/articles/edit/${art.id?c}" title="Edit Artikel" class="text-black hover:text-indigo-600 hover:scale-110 transition">
                          <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path>
                            <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path>
                          </svg>
                        </a>

                        <button type="button" data-id="${art.id?c}" title="Tampilkan/Sembunyikan" class="text-black hover:text-blue-500 hover:scale-110 transition toggle-visibility-btn">
                          <#if art.status?? && art.status?string == "HIDDEN">
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-slate-400">
                              <path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"></path>
                              <line x1="1" y1="1" x2="23" y2="23"></line>
                            </svg>
                          <#else>
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                              <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
                              <circle cx="12" cy="12" r="3"></circle>
                            </svg>
                          </#if>
                        </button>

                        <button type="button" data-id="${art.id?c}" title="Hapus Artikel" class="text-black hover:text-red-500 hover:scale-110 transition delete-btn">
                          <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <polyline points="3 6 5 6 21 6"></polyline>
                            <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                            <line x1="10" y1="11" x2="10" y2="17"></line>
                            <line x1="14" y1="11" x2="14" y2="17"></line>
                          </svg>
                        </button>

                      </div>
                    </td>
                  </tr>
                </#list>
              <#else>
                <tr>
                  <td colspan="5" class="py-20 text-center">
                    <span class="block italic text-stone-400 mb-4">
                      Belum ada artikel yang tersedia <#if searchText?? && searchText != "">untuk kata kunci "<span class="font-bold">${searchText}</span>"</#if>.
                    </span>
                    
                    <#-- Tombol pintasan kembali saat data tidak ditemukan -->
                    <#if searchText?? && searchText != "">
                        <a href="/admin/articles" class="inline-block px-6 py-2.5 bg-slate-100 text-slate-700 rounded-xl hover:bg-slate-200 transition font-semibold text-sm shadow-sm border border-slate-200">
                            Kembali ke Daftar Semua Artikel
                        </a>
                    </#if>
                  </td>
                </tr>
              </#if>

            </tbody>
          </table>
        </div>

        <div class="w-full px-8 py-6 bg-white border border-t-0 border-stone-100 rounded-b-2xl shadow-[0px_5px_20px_rgba(243,237,237,1.0)] flex justify-between items-center text-slate-500 text-sm">
            <span>
                <#if searchText?? && searchText != "">
                    Menampilkan hasil pencarian untuk "${searchText}" (Total: ${totalItems!0} artikel)
                <#else>
                    Menampilkan halaman ${(currentPage!0) + 1} dari ${totalPages!1} (Total: ${totalItems!0} Artikel)
                </#if>
            </span>
            
            <div class="flex gap-4 items-center">
                <#-- Tombol Prev -->
                <#if currentPage?? && currentPage gt 0>
                    <a href="/admin/articles?page=${currentPage - 1}&search=${searchText!''}" class="hover:text-black font-semibold transition">Prev</a>
                <#else>
                    <span class="text-slate-300 cursor-not-allowed font-semibold">Prev</span>
                </#if>

                <#-- Nomor Halaman Dinamis -->
                <div class="flex gap-2">
                    <#if totalPages?? && totalPages gt 0>
                        <#list 0..(totalPages - 1) as i>
                            <#if i == currentPage>
                                <span class="w-8 h-8 flex items-center justify-center bg-[#4338ca] text-white rounded-full font-bold">${i + 1}</span>
                            <#else>
                                <a href="/admin/articles?page=${i}&search=${searchText!''}" class="w-8 h-8 flex items-center justify-center bg-slate-100 hover:bg-slate-200 text-slate-700 rounded-full transition">${i + 1}</a>
                            </#if>
                        </#list>
                    <#else>
                        <span class="w-8 h-8 flex items-center justify-center bg-[#4338ca] text-white rounded-full font-bold">1</span>
                    </#if>
                </div>

                <#-- Tombol Next -->
                <#if currentPage?? && totalPages?? && (currentPage + 1) lt totalPages>
                    <a href="/admin/articles?page=${currentPage + 1}&search=${searchText!''}" class="hover:text-black font-semibold transition">Next</a>
                <#else>
                    <span class="text-slate-300 cursor-not-allowed font-semibold">Next</span>
                </#if>
            </div>
        </div>

      </div>

    </div>

  <script>
    document.addEventListener('DOMContentLoaded', function() {
        // Event delegation tunggal untuk mencegah duplikasi pop-up konfirmasi
        document.body.addEventListener('click', function(e) {
            const toggleBtn = e.target.closest('.toggle-visibility-btn');
            if (toggleBtn) {
                const id = toggleBtn.getAttribute('data-id');
                if (confirm("Ubah status tayang artikel ini?")) {
                    window.location.href = "/admin/articles/toggle-visibility/" + id;
                }
                return;
            }

            const deleteBtn = e.target.closest('.delete-btn');
            if (deleteBtn) {
                const id = deleteBtn.getAttribute('data-id');
                if (confirm("Apakah Anda yakin ingin menghapus artikel ini?")) {
                    window.location.href = "/admin/articles/delete/" + id;
                }
                return;
            }
        });

        // Search debounce & enter handler
        let searchTimeout;
        const searchInput = document.getElementById('searchInput');
        if (searchInput) {
            const searchForm = searchInput.closest('form');
            if (searchForm) {
                searchInput.addEventListener('input', function(e) {
                    clearTimeout(searchTimeout);
                    searchTimeout = setTimeout(function() {
                        if (e.target.value.length >= 3 || e.target.value.length === 0) {
                            searchForm.submit();
                        }
                    }, 500); 
                });
                
                searchInput.addEventListener('keypress', function(e) {
                    if (e.key === 'Enter') {
                        e.preventDefault();
                        clearTimeout(searchTimeout);
                        searchForm.submit();
                    }
                });
            }
        }
    });
  </script>

</@layout.backofficeLayout>
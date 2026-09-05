<#-- Penanda Halaman Aktif untuk Sidebar -->
<#assign activePage = "komentar">
<#-- BACA URL LANGSUNG: Ambil nilai dari ?search=... di browser -->
<#assign currentSearch = RequestParameters['search']!searchKeyword!searchText!''>
<#import "/layout/backoffice_layout.ftl" as layout>

<@layout.backofficeLayout title="Admin - Moderasi Komentar" activePage=activePage adminName=adminName>
      
      <div class="w-full max-w-5xl mx-auto px-4 mb-6">
        <h2 class="text-xl font-bold font-gelasio text-black">Moderasi Komentar Artikel & Berita</h2>
      </div>

      <div class="w-full max-w-5xl mx-auto px-4 mb-8 flex justify-center">
        <form action="/admin/comments" method="GET" class="w-full max-w-2xl relative">
          
          <input type="text" name="search" placeholder="Ketik Sumber Komentar atau Judul Artikel disini" 
                 value="${currentSearch}"
                 class="w-full py-4 px-6 pr-20 bg-white rounded-xl shadow-[0px_2px_10px_rgba(0,0,0,0.05)] border border-slate-100 outline-none font-lato text-center focus:ring-2 focus:ring-indigo-100">
          
          <div class="absolute right-5 top-1/2 transform -translate-y-1/2 flex items-center gap-3">
            <#-- Tombol Silang (X) muncul HANYA jika URL search tidak kosong -->
            <#if currentSearch != "">
              <a href="/admin/comments" class="text-red-400 hover:text-red-600 hover:scale-110 transition bg-red-50 p-1.5 rounded-full" title="Batalkan Pencarian">
                <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                  <line x1="18" y1="6" x2="6" y2="18"></line>
                  <line x1="6" y1="6" x2="18" y2="18"></line>
                </svg>
              </a>
            </#if>
            
            <#-- Tombol Kaca Pembesar (Submit) -->
            <button type="submit" class="text-[#4338ca] hover:scale-125 transition-transform duration-200">
              <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </button>
          </div>
        </form>
      </div>

      <div class="w-full max-w-5xl mx-auto px-4 mb-20">
        <!-- Notifikasi Sukses/Error dari Controller -->
        <#if successMessage??>
            <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded-xl relative mb-4 font-lato">
                ${successMessage}
            </div>
        </#if>
        <#if errorMessage??>
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded-xl relative mb-4 font-lato">
                ${errorMessage}
            </div>
        </#if>

        <div class="w-full overflow-x-auto bg-white rounded-t-2xl shadow-[0px_5px_20px_rgba(243,237,237,1.0)] border border-stone-100">
          <table class="w-full text-center border-collapse min-w-[900px]">
            <thead>
              <tr class="font-lato text-black text-sm border-b border-black">
                <th class="px-6 py-6 border-r border-black/20 w-[15%] font-semibold text-center">Pengirim</th>
                <th class="px-4 py-6 border-r border-black/20 font-semibold w-[15%]">Tanggal</th>
                <th class="px-6 py-6 border-r border-black/20 font-semibold w-[30%]">Isi Pesan</th>
                <th class="px-4 py-6 border-r border-black/20 font-semibold w-[15%]">Sumber</th>
                <th class="px-4 py-6 border-r border-black/20 font-semibold w-[15%]">Status</th>
                <th class="px-4 py-6 font-semibold w-[10%]">Aksi</th>
              </tr>
            </thead>
            <tbody class="font-lato text-black text-sm divide-y divide-transparent">
              
              <#if comments?? && comments?size gt 0>
                <#list comments as c>
                  <tr class="h-24 hover:bg-slate-50 transition border-b border-black/5 last:border-b-0">
                    <td class="px-6 border-r border-black/20 font-bold">${c.sender!''}</td>
                    <td class="px-4 border-r border-black/20 font-bold">${c.commentDate!''}</td>
                    <td class="px-6 border-r border-black/20 text-left font-bold text-slate-800">${c.content!''}</td>
                    
                    <td class="px-4 border-r border-black/20 text-slate-600 text-left">
                      <#if c.article??>
                          <a href="/article/${c.article.id?c}" target="_blank" class="font-semibold text-[#3B5998] hover:underline inline-flex items-center gap-1">
                              ${c.article.title}
                              <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6"></path><polyline points="15 3 21 3 21 9"></polyline><line x1="10" y1="14" x2="21" y2="3"></line></svg>
                          </a>
                      <#else>
                          <span class="text-slate-400 italic">${c.source!'Artikel Umum'}</span>
                      </#if>
                    </td>

                    <td class="px-4 border-r border-black/20 font-medium status-text text-black">
                      <#if c.status?? && c.status == 'Hidden'>Disembunyikan<#else>Tampil</#if>
                    </td>
                    <td class="px-4">
                      <div class="flex justify-center gap-4 items-center">
                        
                        <button type="button" 
                           onclick="executeAdminAction('/admin/comments/toggle/${c.id?c}', 'Ubah status tayang komentar ini?')" 
                           title="Ubah Status Tayang" 
                           class="text-black hover:text-[#4338ca] hover:scale-110 transition inline-block bg-transparent border-none cursor-pointer">
                          <#if c.status?? && c.status == 'Hidden'>
                            <svg class="eye-icon" xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"></path><line x1="1" y1="1" x2="23" y2="23"></line></svg>
                          <#else>
                            <svg class="eye-icon" xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path><circle cx="12" cy="12" r="3"></circle></svg>
                          </#if>
                        </button>

                        <button type="button" 
                           onclick="executeAdminAction('/admin/comments/delete/${c.id?c}', 'Hapus komentar ini secara permanen?')" 
                           title="Hapus Komentar" 
                           class="text-black hover:text-red-500 hover:scale-110 transition inline-block bg-transparent border-none cursor-pointer">
                          <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="3 6 5 6 21 6"></polyline><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path><line x1="10" y1="11" x2="10" y2="17"></line><line x1="14" y1="11" x2="14" y2="17"></line></svg>
                        </button>

                      </div>
                    </td>
                  </tr>
                </#list>
              <#else>
                <tr>
                  <td colspan="6" class="py-20 text-center">
                    <span class="block italic text-stone-400 mb-4">
                      Belum ada komentar masuk <#if currentSearch != "">untuk kata kunci "<span class="font-bold">${currentSearch}</span>"</#if>.
                    </span>
                    
                    <#if currentSearch != "">
                        <a href="/admin/comments" class="inline-block px-6 py-2.5 bg-slate-100 text-slate-700 rounded-xl hover:bg-slate-200 transition font-semibold text-sm shadow-sm border border-slate-200">
                            Kembali ke Daftar Semua Komentar
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
                <#if currentSearch != "">
                    Menampilkan hasil pencarian untuk "${currentSearch}" (Total: ${totalItems!0} komentar)
                <#else>
                    Menampilkan halaman ${(currentPage!0) + 1} dari ${totalPages!1} (Total: ${totalItems!0} Komentar)
                </#if>
            </span>
            
            <div class="flex gap-4 items-center">
                <#if currentPage?? && currentPage gt 0>
                    <a href="/admin/comments?page=${currentPage - 1}&search=${currentSearch}" class="hover:text-[#4338ca] font-semibold transition">Prev</a>
                <#else>
                    <span class="text-slate-300 cursor-not-allowed font-semibold">Prev</span>
                </#if>

                <div class="flex gap-2">
                    <#if totalPages?? && totalPages gt 0>
                        <#list 0..(totalPages - 1) as i>
                            <#if i == currentPage>
                                <span class="w-8 h-8 flex items-center justify-center bg-[#4338ca] text-white rounded-full font-bold shadow-md">${i + 1}</span>
                            <#else>
                                <a href="/admin/comments?page=${i}&search=${currentSearch}" class="w-8 h-8 flex items-center justify-center bg-slate-100 hover:bg-slate-200 text-slate-700 rounded-full transition">${i + 1}</a>
                            </#if>
                        </#list>
                    <#else>
                        <span class="w-8 h-8 flex items-center justify-center bg-[#4338ca] text-white rounded-full font-bold shadow-md">1</span>
                    </#if>
                </div>

                <#if currentPage?? && totalPages?? && (currentPage + 1) lt totalPages>
                    <a href="/admin/comments?page=${currentPage + 1}&search=${currentSearch}" class="hover:text-[#4338ca] font-semibold transition">Next</a>
                <#else>
                    <span class="text-slate-300 cursor-not-allowed font-semibold">Next</span>
                </#if>
            </div>
        </div>
      </div>

  <script>
    function executeAdminAction(targetUrl, confirmMsg) {
        if (confirm(confirmMsg)) {
            var timestamp = new Date().getTime();
            var separator = targetUrl.indexOf('?') !== -1 ? '&' : '?';
            window.location.href = targetUrl + separator + "t=" + timestamp;
        }
    }
  </script>
</@layout.backofficeLayout>
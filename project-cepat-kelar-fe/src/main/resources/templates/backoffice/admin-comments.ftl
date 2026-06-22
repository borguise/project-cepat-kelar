<#assign activePage = "komentar">
<#import "/layout/backoffice_layout.ftl" as layout>

<@layout.backofficeLayout title="Admin - Moderasi Komentar" activePage=activePage adminName=adminName>
      
      <div class="w-full max-w-5xl mx-auto px-4 mb-6">
        <h2 class="text-xl font-bold font-gelasio text-black">Moderasi Komentar Artikel & Berita</h2>
      </div>

      <div class="w-full max-w-5xl mx-auto px-4 mb-8 flex justify-center">
        <form action="/admin/comments" method="GET" class="w-full max-w-2xl relative">
          <input type="text" name="search" placeholder="Ketik Sumber Komentar disini" 
                 value="${searchKeyword!''}"
                 class="w-full py-4 px-6 pr-14 bg-white rounded-xl shadow-[0px_2px_10px_rgba(0,0,0,0.05)] border border-slate-100 outline-none font-lato text-center focus:ring-2 focus:ring-indigo-100">
          
          <button type="submit" class="absolute right-5 top-1/2 transform -translate-y-1/2 text-[#4338ca] hover:scale-125 transition-transform duration-200">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
          </button>
        </form>
      </div>

      <div class="w-full max-w-5xl mx-auto px-4 mb-20">
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
                  <tr class="h-24 hover:bg-slate-50 transition border-b border-black/5 last:border-b-0" id="row-${c.id}">
                    <td class="px-6 border-r border-black/20 font-bold">${c.sender}</td>
                    <td class="px-4 border-r border-black/20 font-bold">${c.commentDate}</td>
                    <td class="px-6 border-r border-black/20 text-left font-bold text-slate-800">${c.content}</td>
                    <td class="px-4 border-r border-black/20 text-slate-600">${c.source}</td>
                    <td class="px-4 border-r border-black/20 font-medium status-text text-black">
                      <#if c.status == 'Hidden'>Disembunyikan<#else>Tampil</#if>
                    </td>
                    <td class="px-4">
                      <div class="flex justify-center gap-4 items-center">
                        
                        <button onclick="toggleEye(${c.id})" title="Ubah Status Tayang" class="text-black hover:text-[#4338ca] hover:scale-110 transition eye-btn">
                          <#if c.status == 'Hidden'>
                            <svg class="eye-icon" xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"></path><line x1="1" y1="1" x2="23" y2="23"></line></svg>
                          <#else>
                            <svg class="eye-icon" xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path><circle cx="12" cy="12" r="3"></circle></svg>
                          </#if>
                        </button>

                        <button onclick="confirmDelete(${c.id})" title="Hapus Komentar" class="text-black hover:text-red-500 hover:scale-110 transition">
                          <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="3 6 5 6 21 6"></polyline><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path><line x1="10" y1="11" x2="10" y2="17"></line><line x1="14" y1="11" x2="14" y2="17"></line></svg>
                        </button>

                      </div>
                    </td>
                  </tr>
                </#list>
              <#else>
                <tr>
                  <td colspan="6" class="py-20 text-center italic text-stone-400">Belum ada komentar masuk.</td>
                </tr>
              </#if>

            </tbody>
          </table>
        </div>

        <div class="w-full px-8 py-6 bg-white border border-t-0 border-stone-100 rounded-b-2xl shadow-[0px_5px_20px_rgba(243,237,237,1.0)] flex justify-between items-center text-slate-500 text-sm">
            <span>Menampilkan ${(comments?size)!0} Komentar</span>
            <div class="flex gap-4 items-center">
                <button class="hover:text-[#4338ca] font-semibold transition">Prev</button>
                <div class="flex gap-2">
                    <span class="w-8 h-8 flex items-center justify-center bg-[#4338ca] text-white rounded-full cursor-pointer shadow-md">1</span>
                </div>
                <button class="hover:text-[#4338ca] font-semibold transition">Next</button>
            </div>
        </div>
      </div>

  <script>
    function toggleEye(id) {
        if(confirm("Ubah status tayang komentar ini?")) {
             window.location.href = "/admin/comments/toggle/" + id;
        }
    }

    function confirmDelete(id) {
        if(confirm("Hapus komentar ini?")) {
            window.location.href = "/admin/comments/delete/" + id;
        }
    }
  </script>
</@layout.backofficeLayout>
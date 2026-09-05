<#-- admin/koleksi.ftl -->
<#assign activePage = "koleksi">
<#-- BACA URL LANGSUNG: Ambil nilai dari ?query=... di browser -->
<#assign currentSearch = RequestParameters['query']!query!''>
<#import "/layout/backoffice_layout.ftl" as layout>

<@layout.backofficeLayout title="Admin - Katalog Koleksi | Graha Pusat Literasi" activePage=activePage adminName=adminName>

  <div class="max-w-6xl w-full mx-auto px-4 mb-4">
    <h2 class="text-3xl font-bold font-gelasio text-slate-800">Katalog Koleksi</h2>
  </div>

  <#if successMessage??><div class="max-w-6xl w-full mx-auto px-4 mb-3"><div class="bg-green-50 border border-green-200 text-green-700 px-6 py-3 rounded-xl text-sm">${successMessage}</div></div></#if>
  <#if errorMessage??><div class="max-w-6xl w-full mx-auto px-4 mb-3"><div class="bg-red-50 border border-red-200 text-red-700 px-6 py-3 rounded-xl text-sm">${errorMessage}</div></div></#if>

  <div class="flex justify-between items-center max-w-6xl w-full mx-auto px-4 mb-5 gap-3">
    
    <#-- FORM PENCARIAN DENGAN TOMBOL RESET (X) -->
    <form action="/admin/collections" method="GET" class="relative w-full max-w-xl flex items-center gap-2">
      <div class="relative w-full">
        <input type="text" name="query" value="${currentSearch}" placeholder="Cari Judul, Pengarang, atau No. Panggil..." 
               class="w-full h-11 pl-6 pr-24 bg-white rounded-xl shadow-sm border border-slate-200 outline-none font-lato text-sm focus:border-indigo-300 focus:ring-1 focus:ring-indigo-300 transition-all">
        
        <#-- Tombol Silang (Reset) Menggunakan SVG agar kebal dari masalah encoding -->
        <#if currentSearch != "">
          <a href="/admin/collections" class="absolute right-16 top-2.5 w-6 h-6 flex items-center justify-center bg-red-50 text-red-500 hover:bg-red-500 hover:text-white rounded-full transition-all" title="Bersihkan Pencarian">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-3 w-3" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="3">
              <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
            </svg>
          </a>
        </#if>

        <button type="submit" class="absolute right-4 top-3 text-slate-400 hover:text-indigo-600 font-semibold text-sm">Cari</button>
      </div>
    </form>
    
    <a href="/admin/collections/new" class="h-11 bg-[#bef264] text-slate-900 px-6 flex items-center justify-center rounded-xl shadow-sm font-bold text-sm hover:bg-[#a3e635] transition-all whitespace-nowrap">
      + Tambah Buku
    </a>
  </div>

  <div class="w-full max-w-6xl mx-auto px-4 mb-6">
    <div class="w-full bg-white rounded-2xl shadow-sm border border-slate-100 overflow-x-auto">
      <table class="w-full border-collapse table-fixed text-center">
        <thead>
          <tr class="bg-slate-50 text-slate-500 text-xs uppercase tracking-wider border-b border-slate-200">
            <th class="w-[12%] px-4 py-5 font-bold text-center">No. Panggil</th>
            <th class="w-[22%] px-4 py-5 font-bold text-center">Judul</th>
            <th class="w-[18%] px-4 py-5 font-bold text-center">Pengarang</th>
            <th class="w-[15%] px-4 py-5 font-bold text-center">Penerbit</th>
            <th class="w-[8%] px-4 py-5 font-bold text-center">Stok</th>
            <th class="w-[13%] px-4 py-5 font-bold text-center">Status</th>
            <th class="w-[12%] px-4 py-5 font-bold text-center">Aksi</th>
          </tr>
        </thead>
        <tbody class="bg-white divide-y divide-slate-100">
          <#if daftarBuku?? && (daftarBuku?size > 0)>
            <#list daftarBuku as buku>
              <tr class="hover:bg-slate-50 transition-colors duration-200">
                <td class="px-2 py-5 text-sm font-bold text-indigo-600 truncate text-center">${buku.callNumber!'-'}</td>
                <td class="px-4 py-5 text-sm font-bold text-slate-800 truncate text-center" title="${buku.title!''}">${buku.title!'-'}</td>
                <td class="px-4 py-5 text-sm text-slate-600 truncate text-center" title="${buku.author!''}">${buku.author!'-'}</td>
                <td class="px-2 py-5 text-sm text-slate-500 truncate text-center">${buku.publisher!'-'}</td>
                <td class="px-2 py-5 text-sm font-medium text-slate-700 text-center">${(buku.stock!0)}</td>
                
                <#-- KOLOM STATUS BARU -->
                <td class="px-2 py-5 text-center">
                  <span class="inline-flex px-3 py-1 rounded-full text-[11px] font-bold border 
                    <#if (buku.status!'') == 'PUBLISHED'>bg-green-50 text-green-700 border-green-200<#else>bg-yellow-50 text-yellow-700 border-yellow-200</#if>">
                    <#if (buku.status!'') == 'PUBLISHED'>Dipublikasikan<#else>Disembunyikan</#if>
                  </span>
                </td>

                <td class="px-2 py-5">
                  <div class="flex justify-center items-center gap-3 text-slate-400">
                    <a href="/admin/collections/edit/${buku.id?c}" title="Edit" class="text-indigo-600 hover:text-indigo-800 transition">
                      <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
                      </svg>
                    </a>
                    <a href="/admin/collections/delete/${buku.id?c}" onclick="return confirm('Hapus buku ini?')" title="Hapus" class="text-red-500 hover:text-red-700 transition">
                      <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                      </svg>
                    </a>
                  </div>
                </td>
              </tr>
            </#list>
          <#else>
            <#-- KONDISI TABEL KOSONG + TOMBOL RESET -->
            <tr>
              <td colspan="7" class="py-16 text-center text-slate-500">
                <div class="flex flex-col items-center justify-center gap-2">
                  <span class="italic text-slate-400 mb-2">
                    <#if currentSearch != "">
                      Data koleksi untuk pencarian <strong>"${currentSearch}"</strong> tidak ditemukan.
                    <#else>
                      Belum ada data koleksi tersedia.
                    </#if>
                  </span>
                  
                  <#-- Tombol Kembali muncul HANYA jika sedang melakukan pencarian -->
                  <#if currentSearch != "">
                    <a href="/admin/collections" class="mt-2 px-5 py-2 bg-indigo-50 text-indigo-600 hover:bg-indigo-600 hover:text-white rounded-lg font-bold transition-all text-sm shadow-sm">
                      Kembali ke Daftar Seluruh Koleksi
                    </a>
                  </#if>
                </div>
              </td>
            </tr>
          </#if>
        </tbody>
      </table>

      <!-- BAGIAN BAWAH TABEL & PAGINASI DINAMIS -->
      <div class="px-8 py-5 bg-slate-50 border-t border-slate-100 flex justify-between items-center text-slate-500 text-sm">
          <span>Menampilkan halaman ${currentPage!1} dari ${totalPages!0} (Total: ${totalItems!0} Koleksi)</span>
          
          <div class="flex gap-2 items-center">
            <#if currentPage?? && currentPage &gt; 1>
                <a href="?page=${currentPage - 1}<#if currentSearch != "">&query=${currentSearch}</#if>" class="px-3 py-1 hover:bg-slate-200 text-slate-700 rounded transition font-medium">Prev</a>
            <#else>
                <span class="px-3 py-1 text-slate-300 cursor-not-allowed">Prev</span>
            </#if>

            <div class="flex gap-1">
                <#if totalPages?? && totalPages &gt; 0>
                    <#list 1..totalPages as p>
                        <#if p == currentPage>
                            <span class="w-8 h-8 flex items-center justify-center bg-indigo-600 text-white rounded-lg shadow-sm font-medium">${p}</span>
                        <#else>
                            <a href="?page=${p}<#if currentSearch != "">&query=${currentSearch}</#if>" class="w-8 h-8 flex items-center justify-center hover:bg-slate-200 text-slate-700 rounded-lg transition font-medium">${p}</a>
                        </#if>
                    </#list>
                <#else>
                    <span class="w-8 h-8 flex items-center justify-center bg-indigo-600 text-white rounded-lg shadow-sm font-medium">1</span>
                </#if>
            </div>

            <#if currentPage?? && totalPages?? && currentPage &lt; totalPages>
                <a href="?page=${currentPage + 1}<#if currentSearch != "">&query=${currentSearch}</#if>" class="px-3 py-1 hover:bg-slate-200 text-slate-700 rounded transition font-medium">Next</a>
            <#else>
                <span class="px-3 py-1 text-slate-300 cursor-not-allowed">Next</span>
            </#if>
          </div>
      </div>
    </div>
  </div> 

</@layout.backofficeLayout>
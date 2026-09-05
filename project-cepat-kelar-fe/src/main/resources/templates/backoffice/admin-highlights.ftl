<#assign activePage = "sorotan">
<#-- BACA URL LANGSUNG: Ambil nilai dari ?query=... di browser untuk mencegah error UI -->
<#assign currentSearch = RequestParameters['query']!query!''>
<#import "/layout/backoffice_layout.ftl" as layout>
<#assign totalSorotan = (sorotanList?size)!0>

<@layout.backofficeLayout title="Admin - Daftar Sorotan" activePage=activePage adminName=adminName>

  <div class="max-w-6xl w-full mx-auto px-4 mb-4">
    <h2 class="text-3xl font-bold font-gelasio text-slate-800">Sorotan Pengguna</h2>
  </div>

  <div class="flex justify-between items-center max-w-6xl w-full mx-auto px-4 mb-6 gap-4">
    <form action="/admin/highlights" method="GET" class="relative w-full max-w-xl">
      <input type="text" name="query" value="${currentSearch}" placeholder="Cari pertanyaan atau jawaban..." 
             class="w-full h-12 pl-6 pr-24 bg-white rounded-xl shadow-sm border border-slate-200 outline-none font-lato text-sm focus:border-indigo-300 focus:ring-1 focus:ring-indigo-300 transition-all">
      
      <div class="absolute right-3 top-1/2 transform -translate-y-1/2 flex items-center gap-3">
        <#-- Tombol Silang (X) muncul HANYA jika URL search tidak kosong -->
        <#if currentSearch != "">
          <a href="/admin/highlights" class="text-red-400 hover:text-red-600 transition bg-red-50 p-1.5 rounded-full" title="Batalkan Pencarian">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
              <line x1="18" y1="6" x2="6" y2="18"></line>
              <line x1="6" y1="6" x2="18" y2="18"></line>
            </svg>
          </a>
        </#if>
        <button type="submit" class="text-slate-400 hover:text-indigo-600 transition font-semibold text-sm px-2">Cari</button>
      </div>
    </form>
    
    <a href="/admin/highlights/new" class="h-12 bg-[#bef264] text-slate-900 px-7 flex items-center justify-center rounded-xl shadow-sm font-bold text-sm hover:bg-[#a3e635] transition-all active:scale-[0.98]">
      + Tambah Poin Info
    </a>
  </div>

  <!-- BLOK NOTIFIKASI SUKSES / ERROR -->
  <div class="max-w-6xl w-full mx-auto px-4">
    <#if successMessage??>
      <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded-xl mb-4 font-lato text-sm">
        ${successMessage}
      </div>
    </#if>
    <#if errorMessage??>
      <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded-xl mb-4 font-lato text-sm">
        ${errorMessage}
      </div>
    </#if>
  </div>

  <div class="w-full max-w-6xl mx-auto px-4 mb-12">
    <div class="w-full bg-white rounded-2xl shadow-sm border border-slate-100 overflow-hidden">
      <table class="w-full border-collapse">
        <thead>
          <tr class="font-lato text-slate-400 text-xs uppercase tracking-wider border-b border-slate-100 bg-slate-50/50">
            <th class="px-8 py-5 text-center font-semibold">Judul / Pertanyaan</th>
            <th class="px-6 py-5 font-semibold text-center w-32">Urutan</th>
            <th class="px-6 py-5 font-semibold text-center w-32">Status</th>
            <th class="px-6 py-5 font-semibold text-center w-32">Aksi</th>
          </tr>
        </thead>
        <tbody class="font-['Lato'] text-slate-700 divide-y divide-slate-50">
          <#if sorotanList?? && (sorotanList?size > 0)>
            <#list sorotanList as item>
              <tr class="hover:bg-slate-50/80 transition-colors duration-200 h-20">
                <td class="px-8 py-4 text-center font-medium text-slate-800 leading-tight">${item.question!""}</td>
                <td class="px-6 py-4 text-center font-medium text-slate-500">Nomor ${item.displayOrder!0}</td>
                <td class="px-6 py-4 text-center">
                  <#assign statusLabel = "Dipublikasikan">
                  <#assign statusClass = "bg-green-50 text-green-700 border border-green-200">
                  <#if item.status?? && (item.status?string == "HIDDEN" || item.status?string == "Hidden")>
                    <#assign statusLabel = "Disembunyikan">
                    <#assign statusClass = "bg-slate-100 text-slate-600 border border-slate-200">
                  </#if>
                  <span class="inline-flex px-3 py-1 rounded-full text-xs font-bold ${statusClass}">${statusLabel}</span>
                </td>
                <td class="px-6 py-4">
                  <div class="flex justify-center gap-4 text-sm font-semibold">
                    <a href="/admin/highlights/edit/${item.id?c}" title="Edit" class="text-indigo-600 hover:text-indigo-800 transition flex items-center gap-1">
                      <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
                      </svg>
                      Edit
                    </a>
                    <a href="/admin/highlights/delete/${item.id?c}" onclick="return confirm('Hapus data ini?')" title="Hapus" class="text-red-500 hover:text-red-700 transition flex items-center gap-1">
                      <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                      </svg>
                      Hapus
                    </a>
                  </div>
                </td>
              </tr>
            </#list>
          <#else>
            <tr>
              <td colspan="4" class="py-16 text-center">
                <span class="block italic text-slate-400 mb-4">
                  Belum ada data sorotan tersedia <#if currentSearch != "">untuk kata kunci "<span class="font-bold">${currentSearch}</span>"</#if>.
                </span>
                
                <#if currentSearch != "">
                    <a href="/admin/highlights" class="inline-block px-6 py-2.5 bg-slate-100 text-slate-700 rounded-xl hover:bg-slate-200 transition font-semibold text-sm shadow-sm border border-slate-200">
                        Kembali ke Daftar Semua Sorotan
                    </a>
                </#if>
              </td>
            </tr>
          </#if>
        </tbody>
      </table>

      <!-- BAGIAN BAWAH TABEL & PAGINASI -->
      <div class="px-8 py-6 flex flex-col sm:flex-row justify-between items-center text-slate-500 text-sm border-t border-slate-100">
          <span>
              <#if currentSearch != "">
                  Menampilkan hasil pencarian (Total: ${totalItems!0} sorotan)
              <#else>
                  Menampilkan halaman ${currentPage!1} dari ${totalPages!0} (Total: ${totalItems!0} Sorotan)
              </#if>
          </span>
          
          <div class="flex items-center gap-4 font-medium mt-4 sm:mt-0">
              <#-- Tombol Sebelumnya (Teks Saja) -->
              <#if currentPage?? && currentPage &gt; 1>
                  <a href="?page=${currentPage - 1}<#if currentSearch != "">&query=${currentSearch}</#if>" class="text-slate-400 hover:text-indigo-700 transition">Prev</a>
              <#else>
                  <span class="text-slate-300 cursor-not-allowed">Prev</span>
              </#if>

              <#-- Nomor Halaman (Lingkaran) -->
              <div class="flex gap-2">
                  <#if totalPages?? && totalPages &gt; 0>
                      <#list 1..totalPages as p>
                          <#if p == currentPage>
                              <!-- Lingkaran Biru Gelap Untuk Halaman Aktif -->
                              <span class="w-8 h-8 flex items-center justify-center rounded-full bg-[#3730a3] text-white font-bold shadow-sm">${p}</span>
                          <#else>
                              <a href="?page=${p}<#if currentSearch != "">&query=${currentSearch}</#if>" class="w-8 h-8 flex items-center justify-center rounded-full text-slate-500 hover:bg-indigo-50 hover:text-[#3730a3] transition">${p}</a>
                          </#if>
                      </#list>
                  <#else>
                      <!-- Tampilan Default Jika Kosong -->
                      <span class="w-8 h-8 flex items-center justify-center rounded-full bg-[#3730a3] text-white font-bold shadow-sm">1</span>
                  </#if>
              </div>

              <#-- Tombol Selanjutnya (Teks Saja) -->
              <#if currentPage?? && totalPages?? && currentPage &lt; totalPages>
                  <a href="?page=${currentPage + 1}<#if currentSearch != "">&query=${currentSearch}</#if>" class="text-slate-400 hover:text-indigo-700 transition">Next</a>
              <#else>
                  <span class="text-slate-300 cursor-not-allowed">Next</span>
              </#if>
          </div>
      </div>
      
    </div>
  </div> 

</@layout.backofficeLayout>
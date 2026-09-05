<#-- admin/audio.ftl -->
<#assign activePage = "audio">
<#-- BACA URL LANGSUNG: Ambil nilai dari ?query=... di browser untuk mencegah error UI -->
<#assign currentSearch = RequestParameters['query']!query!''>
<#import "/layout/backoffice_layout.ftl" as layout>

<@layout.backofficeLayout title="Admin - Daftar Audio" activePage=activePage adminName=adminName>

  <div class="max-w-6xl w-full mx-auto px-4 mb-4">
    <h2 class="text-3xl font-bold font-gelasio text-slate-800 italic">Daftar Rekaman Audio</h2>
  </div>

  <#if successMessage??><div class="max-w-6xl w-full mx-auto px-4 mb-4"><div class="bg-green-50 border border-green-200 text-green-700 px-6 py-4 rounded-xl text-sm">${successMessage}</div></div></#if>
  <#if errorMessage??><div class="max-w-6xl w-full mx-auto px-4 mb-4"><div class="bg-red-50 border border-red-200 text-red-700 px-6 py-4 rounded-xl text-sm">${errorMessage}</div></div></#if>

  <div class="flex justify-between items-center max-w-6xl w-full mx-auto px-4 mb-6 gap-6">
    <form action="/admin/audio" method="GET" class="relative w-full max-w-xl flex items-center">
      <div class="relative w-full">
        <input type="text" name="query" value="${currentSearch}" placeholder="Cari judul atau nomor panggil..." 
               class="w-full h-12 pl-6 pr-24 bg-white rounded-xl shadow-sm border border-slate-200 outline-none font-lato text-sm focus:border-indigo-300 focus:ring-1 focus:ring-indigo-300 transition-all">
        
        <#-- Tombol Silang (X) muncul HANYA jika URL search tidak kosong -->
        <#if currentSearch != "">
          <a href="/admin/audio" class="absolute right-16 top-3 w-6 h-6 flex items-center justify-center bg-red-50 text-red-500 hover:bg-red-500 hover:text-white rounded-full transition-all" title="Bersihkan Pencarian">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-3 w-3" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="3">
              <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
            </svg>
          </a>
        </#if>

        <button type="submit" class="absolute right-4 top-3.5 text-slate-400 hover:text-indigo-600 font-semibold text-sm">Cari</button>
      </div>
    </form>

    <a href="/admin/audio/new" class="h-12 bg-[#bef264] text-indigo-900 px-6 flex items-center justify-center rounded-xl shadow-sm font-bold text-sm hover:bg-lime-400 transition-all whitespace-nowrap">
      + Tambah Rekaman Audio
    </a>
  </div>

  <div class="max-w-6xl w-full mx-auto px-4 mb-14">
    <div class="w-full bg-white rounded-2xl shadow-sm border border-slate-100 overflow-hidden">
      <table class="w-full border-collapse table-fixed text-center shadow-sm border border-slate-200 rounded-2xl overflow-hidden">
        <thead>
          <tr class="bg-slate-50 text-slate-500 text-xs uppercase tracking-wider border-b border-slate-200">
            <th class="w-[10%] px-4 py-5 font-bold">No. Panggil</th>
            <th class="w-[20%] px-4 py-5 font-bold">Judul</th>
            <th class="w-[20%] px-4 py-5 font-bold">Kreator</th>
            <th class="w-[12%] px-4 py-5 font-bold">Fisik</th>
            <th class="w-[18%] px-4 py-5 font-bold">Pemutar Audio</th>
            <th class="w-[20%] px-4 py-5 font-bold">Aksi</th>
          </tr>
        </thead>
        <tbody class="bg-white divide-y divide-slate-100">
          <#if audioRecordings?? && (audioRecordings?size gt 0)>
            <#list audioRecordings as audio>
              <tr class="hover:bg-slate-50 transition-colors">
                <td class="px-2 py-5 text-xs font-bold text-indigo-600 truncate">${audio.callNumber!'-'}</td>
                <td class="px-4 py-5 text-sm font-semibold text-slate-800 truncate" title="${audio.title!''}">${audio.title!'-'}</td>
                <td class="px-4 py-5 text-sm text-slate-600 truncate" title="${audio.responsibility!''}">${audio.responsibility!'-'}</td>
                <td class="px-2 py-5 text-xs text-slate-500 truncate">${audio.mediaType!'-'}</td>
                
                <!-- KOLOM PEMUTAR AUDIO ADMIN (DISAMAKAN BERDASARKAN KATA KUNCI JUDUL) -->
                <td class="px-2 py-5 text-center">
                  <audio controls class="h-9 w-40 mx-auto">
                    <#if (audio.title?lower_case)?contains("peminjaman")>
                        <source src="/audio/meminjam.mp3" type="audio/mpeg">
                    <#elseif (audio.title?lower_case)?contains("pendaftaran")>
                        <source src="/audio/daftaranggota.mp3" type="audio/mpeg">
                    <#elseif (audio.title?lower_case)?contains("lumbung")>
                        <source src="/audio/marsperpus.mp3" type="audio/mpeg">
                    <#else>
                        <source src="/audio/indonesiaraya.mp3" type="audio/mpeg">
                    </#if>
                    Browser Anda tidak mendukung audio.
                  </audio>
                </td>

                <td class="px-2 py-5">
                  <div class="flex justify-center gap-3">
                    <a href="/audio/detail?id=${audio.id?c}" target="_blank" title="Preview Kiosk" class="text-green-600 hover:text-green-800 transition flex items-center justify-center">
                      <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14.752 11.168l-3.197-2.132A1 1 0 0010 9.87v4.263a1 1 0 001.555.832l3.197-2.132a1 1 0 000-1.664z" />
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                      </svg>
                    </a>
                    <a href="/admin/audio/edit/${audio.id?c}" title="Edit" class="text-indigo-600 hover:text-indigo-800 transition">
                      <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
                      </svg>
                    </a>
                    <a href="/admin/audio/delete/${audio.id?c}" onclick="return confirm('Hapus rekaman audio ini?')" title="Hapus" class="text-red-500 hover:text-red-700 transition">
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
              <td colspan="6" class="py-16 text-center text-slate-500">
                <div class="flex flex-col items-center justify-center gap-2">
                  <span class="italic text-slate-400 mb-2">
                    <#if currentSearch != "">
                      Data rekaman audio untuk pencarian <strong>"${currentSearch}"</strong> tidak ditemukan.
                    <#else>
                      Belum ada data rekaman audio tersedia.
                    </#if>
                  </span>
                  
                  <#-- Tombol Kembali muncul HANYA jika sedang melakukan pencarian -->
                  <#if currentSearch != "">
                    <a href="/admin/audio" class="mt-2 px-6 py-2.5 bg-indigo-50 text-indigo-600 hover:bg-indigo-600 hover:text-white rounded-xl font-medium text-sm transition-all shadow-sm">
                      Kembali ke Daftar Seluruh Audio
                    </a>
                  </#if>
                </div>
              </td>
            </tr>
          </#if>
        </tbody>
      </table>

      <div class="px-8 py-5 bg-slate-50 border-t border-slate-100 flex justify-between items-center text-slate-500 text-sm">
          <span>
              <#if currentSearch != "">
                  Menampilkan hasil pencarian (Total: ${totalItems!0} Audio)
              <#else>
                  Menampilkan halaman ${(currentPage!0) + 1} dari ${totalPages!1} (Total: ${totalItems!0} Audio)
              </#if>
          </span>
          
          <div class="flex gap-2 items-center">
            <#if currentPage?? && currentPage &gt; 0>
                <a href="?page=${currentPage - 1}<#if currentSearch != "">&query=${currentSearch}</#if>" class="px-3 py-1 hover:bg-slate-200 text-slate-700 rounded transition font-medium">Prev</a>
            <#else>
                <span class="px-3 py-1 text-slate-300 cursor-not-allowed">Prev</span>
            </#if>

            <div class="flex gap-1">
                <#if totalPages?? && totalPages &gt; 0>
                    <#list 0..(totalPages - 1) as p>
                        <#if p == currentPage>
                            <span class="w-8 h-8 flex items-center justify-center bg-indigo-600 text-white rounded-lg shadow-sm font-medium">${p + 1}</span>
                        <#else>
                            <a href="?page=${p}<#if currentSearch != "">&query=${currentSearch}</#if>" class="w-8 h-8 flex items-center justify-center hover:bg-slate-200 text-slate-700 rounded-lg transition font-medium">${p + 1}</a>
                        </#if>
                    </#list>
                <#else>
                    <span class="w-8 h-8 flex items-center justify-center bg-indigo-600 text-white rounded-lg shadow-sm font-medium">1</span>
                </#if>
            </div>

            <#if currentPage?? && totalPages?? && (currentPage + 1) &lt; totalPages>
                <a href="?page=${currentPage + 1}<#if currentSearch != "">&query=${currentSearch}</#if>" class="px-3 py-1 hover:bg-slate-200 text-slate-700 rounded transition font-medium">Next</a>
            <#else>
                <span class="px-3 py-1 text-slate-300 cursor-not-allowed">Next</span>
            </#if>
          </div>
      </div>
    </div>
  </div>

</@layout.backofficeLayout>
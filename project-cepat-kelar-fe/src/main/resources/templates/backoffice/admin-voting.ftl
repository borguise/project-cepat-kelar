<#-- admin/voting.ftl -->
<#assign activePage = "voting">
<#-- BACA URL LANGSUNG: Ambil nilai dari ?query=... di browser -->
<#assign currentSearch = RequestParameters['query']!query!''>
<#import "/layout/backoffice_layout.ftl" as layout>

<#-- Pengecekan aman untuk total data -->
<#assign totalVoting = (votingList?? && votingList?has_content)?then(votingList?size, 0)>

<@layout.backofficeLayout title="Admin - Daftar Voting" activePage=activePage adminName=adminName>

  <div class="max-w-6xl w-full mx-auto px-4 mb-6">
    <h2 class="text-3xl font-bold font-gelasio text-slate-800 italic">Daftar Pemilihan & Voting</h2>
  </div>

  <#-- Notifikasi -->
  <#if successMessage??><div class="max-w-6xl w-full mx-auto px-4 mb-4"><div class="bg-green-50 border border-green-200 text-green-700 px-6 py-4 rounded-xl text-sm">${successMessage}</div></div></#if>
  <#if errorMessage??><div class="max-w-6xl w-full mx-auto px-4 mb-4"><div class="bg-red-50 border border-red-200 text-red-700 px-6 py-4 rounded-xl text-sm">${errorMessage}</div></div></#if>

  <#-- Search & Action Bar -->
  <div class="flex justify-between items-center max-w-6xl w-full mx-auto px-4 mb-8 gap-4">
    
    <!-- PERBAIKAN: action diubah dari /admin/voting/search menjadi /admin/voting -->
    <form action="/admin/voting" method="GET" class="relative w-full max-w-xl">
       <input type="text" name="query" value="${currentSearch}" placeholder="Cari Judul atau Kategori disini..." 
              class="w-full h-11 pl-6 pr-24 bg-white rounded-xl shadow-sm border border-slate-200 outline-none font-lato text-sm focus:border-indigo-300 focus:ring-1 focus:ring-indigo-300 transition-all">
       
       <#-- Tombol Silang (X) muncul HANYA jika URL search tidak kosong -->
       <#if currentSearch != "">
         <a href="/admin/voting" class="absolute right-16 top-2.5 w-6 h-6 flex items-center justify-center bg-red-50 text-red-500 hover:bg-red-500 hover:text-white rounded-full transition-all" title="Bersihkan Pencarian">
           <svg xmlns="http://www.w3.org/2000/svg" class="h-3 w-3" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="3">
             <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
           </svg>
         </a>
       </#if>

       <button type="submit" class="absolute right-4 top-3 text-slate-400 hover:text-indigo-600 font-semibold text-sm">Cari</button>
    </form>
    
    <a href="/admin/voting/new" class="h-11 bg-[#bef264] text-indigo-900 px-6 flex items-center justify-center rounded-xl shadow-sm font-bold text-sm hover:bg-lime-400 transition-all active:scale-95 whitespace-nowrap">
      + Tambah Pemilihan
    </a>
  </div>

  <#-- Table Section -->
  <div class="w-full max-w-6xl mx-auto px-4 mb-12">
    <div class="w-full bg-white rounded-2xl shadow-sm border border-slate-200 overflow-x-auto">
      
      <table class="w-full border-collapse table-fixed text-center">
        <thead>
          <tr class="bg-slate-50 text-slate-500 text-xs uppercase tracking-wider border-b border-slate-200">
            <th class="w-[30%] px-4 py-5 font-bold text-center">Nama Pemilihan</th>
            <th class="w-[25%] px-4 py-5 font-bold text-center">Periode</th>
            <th class="w-[15%] px-4 py-5 font-bold text-center">Partisipan</th>
            <th class="w-[15%] px-4 py-5 font-bold text-center">Status</th>
            <th class="w-[15%] px-4 py-5 font-bold text-center">Aksi</th>
          </tr>
        </thead>
        <tbody class="bg-white divide-y divide-slate-100 font-lato text-slate-700">
          <#if votingList?? && (votingList?size gt 0)>
            <#list votingList as vote>
              <tr class="hover:bg-slate-50 transition-colors duration-200">
                <td class="px-4 py-5 text-sm font-bold text-slate-800 truncate text-center" title="${vote.name!''}">${vote.name!'-'}</td>
                <td class="px-4 py-5 text-sm text-slate-500 truncate text-center">${vote.periodStart!''} - ${vote.periodEnd!''}</td>
                <td class="px-4 py-5 text-sm font-bold text-indigo-600 text-center">${vote.participantCount!0}</td>
                <td class="px-4 py-5 text-sm text-center">
                    <#if vote.status == 'Aktif'>
                        <span class="px-3 py-1 bg-green-100 text-green-700 border border-green-200 rounded-full font-bold text-xs inline-block">Aktif</span>
                    <#else>
                        <span class="px-3 py-1 bg-slate-100 text-slate-500 border border-slate-200 rounded-full font-medium text-xs inline-block">${vote.status!'Selesai'}</span>
                    </#if>
                </td>
                <td class="px-4 py-5 text-center">
                  <div class="flex justify-center items-center gap-3 text-slate-400 text-xs font-bold">
                    <a href="/admin/voting/edit/${vote.id}" title="Edit" class="hover:text-indigo-600 transition">Edit</a>
                    
                    <!-- PERHATIAN TIM BACKEND: Pastikan URL ini sudah ada Controller-nya -->
                    <a href="/admin/voting/result/${vote.id}" title="Lihat Hasil" class="hover:text-green-600 transition">View</a>
                    
                    <!-- PERHATIAN TIM BACKEND: Pastikan ada CascadeType.REMOVE di entity Voting agar hapus berjalan mulus -->
                    <form action="/admin/voting/delete/${vote.id}" method="POST" onsubmit="return confirm('Hapus pemilihan ini?')" class="m-0 p-0 inline-flex items-center">
                      <button type="submit" title="Hapus" class="hover:text-red-500 transition">Del</button>
                    </form>
                  </div>
                </td>
              </tr>
            </#list>
          <#else>
            <tr>
              <td colspan="5" class="py-16 text-center text-slate-500">
                <div class="flex flex-col items-center justify-center gap-2">
                  <span class="italic text-slate-400 mb-2">
                    <#if currentSearch != "">
                      Data pemilihan untuk pencarian <strong>"${currentSearch}"</strong> tidak ditemukan.
                    <#else>
                      Belum ada data pemilihan yang dibuat.
                    </#if>
                  </span>
                  
                  <#if currentSearch != "">
                    <a href="/admin/voting" class="mt-2 px-6 py-2.5 bg-indigo-50 text-indigo-600 hover:bg-indigo-600 hover:text-white rounded-xl font-medium text-sm transition-all shadow-sm">
                      Kembali ke Daftar Seluruh Voting
                    </a>
                  </#if>
                </div>
              </td>
            </tr>
          </#if>
        </tbody>
      </table>

      <#-- Paginasi Fungsional -->
      <div class="px-6 py-4 bg-slate-50 border-t border-slate-100 flex justify-between items-center text-slate-500 text-xs">
          <span>Menampilkan ${totalVoting} Data Pemilihan</span>
          <div class="flex gap-1 items-center">
             <a href="?page=${(currentPage!1) - 1}<#if currentSearch != "">&query=${currentSearch}</#if>" class="px-2 py-1 hover:bg-slate-200 rounded transition ${((currentPage!1) <= 1)?string('pointer-events-none opacity-50', '')}">Prev</a>
             <span class="px-3 py-1 bg-indigo-600 text-white rounded-lg shadow-sm font-medium">${currentPage!1}</span>
             <a href="?page=${(currentPage!1) + 1}<#if currentSearch != "">&query=${currentSearch}</#if>" class="px-2 py-1 hover:bg-slate-200 rounded transition">Next</a>
          </div>
      </div>
      
    </div> 
  </div> 

</@layout.backofficeLayout>
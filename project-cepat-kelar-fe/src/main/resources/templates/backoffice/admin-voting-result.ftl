<#-- admin/admin-voting-result.ftl -->
<#assign activePage = "voting">
<#import "/layout/backoffice_layout.ftl" as layout>

<@layout.backofficeLayout title="Admin - Hasil Voting" activePage=activePage adminName=adminName>

  <div class="max-w-4xl w-full mx-auto px-4 mb-6 flex justify-between items-center">
    <div>
      <h2 class="text-3xl font-bold font-gelasio text-slate-800 italic">Hasil Perolehan Suara</h2>
      <p class="text-slate-500 text-sm mt-1">Pemilihan: <span class="font-bold text-indigo-600">${(voting.name)!'-'}</span></p>
    </div>
    <a href="/admin/voting" class="px-6 py-2.5 bg-white border border-slate-200 text-slate-700 hover:bg-slate-50 hover:text-indigo-600 rounded-xl font-medium text-sm transition-all shadow-sm">
      Kembali
    </a>
  </div>

  <div class="max-w-4xl w-full mx-auto px-4 mb-12">
    
    <#-- Kartu Ringkasan Informasi -->
    <div class="bg-indigo-600 rounded-3xl p-8 shadow-md mb-8 text-white flex flex-col md:flex-row justify-between items-start md:items-center gap-6">
      <div>
        <span class="text-indigo-200 text-xs font-bold uppercase tracking-wider block mb-1">Total Suara Masuk</span>
        <p class="text-5xl font-bold font-gelasio">${totalVotes!0}</p>
      </div>
      <div class="md:text-right border-t md:border-t-0 border-indigo-500/50 pt-4 md:pt-0 w-full md:w-auto">
        <span class="text-indigo-200 text-xs font-bold uppercase tracking-wider block mb-1">Periode Pemilihan</span>
        <p class="text-base font-semibold mb-2">${(voting.startDate)!'-'} s/d ${(voting.endDate)!'-'}</p>
        <div>
            <span class="inline-px px-3 py-1 bg-white/20 rounded-full text-xs font-bold border border-white/30 backdrop-blur-sm">
                Status: ${(voting.status)!'Draft'}
            </span>
        </div>
      </div>
    </div>

    <#-- Tabel Perolehan Suara Kandidat -->
    <div class="w-full bg-white rounded-3xl shadow-sm border border-slate-200 overflow-hidden">
      <div class="p-6 border-b border-slate-100">
        <h3 class="text-xl font-bold font-gelasio text-slate-800">Statistik Kandidat</h3>
      </div>
      
      <table class="w-full border-collapse table-fixed text-left">
        <thead>
          <tr class="bg-slate-50 text-slate-500 text-xs uppercase tracking-wider border-b border-slate-200">
            <th class="w-[50%] px-6 py-5 font-bold">Kandidat / Pilihan</th>
            <th class="w-[30%] px-6 py-5 font-bold">Keterangan / Visi Misi</th>
            <th class="w-[20%] px-6 py-5 font-bold text-center">Jumlah Suara</th>
          </tr>
        </thead>
        <tbody class="divide-y divide-slate-100 font-lato text-slate-700">
          <#if entries?? && (entries?size gt 0)>
            <#list entries as entry>
              <tr class="hover:bg-slate-50 transition-colors duration-200">
                <td class="px-6 py-5">
                  <div class="font-bold text-slate-800 text-base">${entry.name!'-'}</div>
                </td>
                <td class="px-6 py-5 text-sm text-slate-500">
                    <span class="block truncate" title="${entry.summary!'-'}">${entry.summary!'-'}</span>
                </td>
                <td class="px-6 py-5 text-center">
                  <div class="inline-flex items-center justify-center min-w-[3.5rem] px-4 py-1.5 bg-green-50 text-green-700 border border-green-200 rounded-xl font-bold text-lg shadow-sm">
                    ${entry.voteCount!0}
                  </div>
                </td>
              </tr>
            </#list>
          <#else>
            <tr>
              <td colspan="3" class="py-16 text-center text-slate-400 italic font-lato">Belum ada kandidat atau opsi yang terdaftar pada pemilihan ini.</td>
            </tr>
          </#if>
        </tbody>
      </table>
    </div>

  </div>

</@layout.backofficeLayout>
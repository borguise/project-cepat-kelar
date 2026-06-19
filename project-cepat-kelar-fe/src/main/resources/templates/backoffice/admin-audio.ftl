<#-- admin/audio.ftl -->
<#assign activePage = "audio">
<#import "/layout/backoffice_layout.ftl" as layout>

<#-- Pengecekan aman untuk totalAudio -->
<#assign totalAudio = (audioRecordings?? && audioRecordings?has_content)?then(audioRecordings?size, 0)>

<@layout.backofficeLayout title="Admin - Daftar Audio" activePage=activePage adminName=adminName>

  <div class="max-w-6xl w-full mx-auto px-4 mb-4">
    <h2 class="text-3xl font-bold font-gelasio text-slate-800 italic">Daftar Rekaman Audio</h2>
  </div>

  <#-- Notifikasi -->
  <#if successMessage??><div class="max-w-6xl w-full mx-auto px-4 mb-4"><div class="bg-green-50 border border-green-200 text-green-700 px-6 py-4 rounded-xl text-sm">${successMessage}</div></div></#if>
  <#if errorMessage??><div class="max-w-6xl w-full mx-auto px-4 mb-4"><div class="bg-red-50 border border-red-200 text-red-700 px-6 py-4 rounded-xl text-sm">${errorMessage}</div></div></#if>

  <#-- Search & Add Bar -->
  <div class="flex justify-between items-center max-w-6xl w-full mx-auto px-4 mb-6 gap-6">
    <form action="/admin/audio/search" method="GET" class="relative w-full max-w-xl">
      <input type="text" name="query" value="${query!''}" placeholder="Cari judul atau nomor panggil..." 
             class="w-full h-12 pl-6 pr-20 bg-white rounded-xl shadow-sm border border-slate-200 outline-none font-lato text-sm focus:border-indigo-300 focus:ring-1 focus:ring-indigo-300 transition-all">
      <button type="submit" class="absolute right-4 top-3.5 text-slate-400 hover:text-indigo-600 font-semibold text-sm">Cari</button>
    </form>

    <a href="/admin/audio/new" class="h-12 bg-[#bef264] text-indigo-900 px-2 flex items-center justify-center rounded-xl shadow-sm font-bold text-sm hover:bg-lime-400 transition-all whitespace-nowrap">
      + Tambah Rekaman Audio
    </a>
  </div>

  <#-- Table Section -->
  <div class="w-full max-w-6xl mx-auto px-4 mb-14">
    <div class="w-full bg-white rounded-2xl shadow-sm border border-slate-100 overflow-hidden">
      <table class="w-full border-collapse table-fixed text-center shadow-sm border border-slate-200 rounded-2xl overflow-hidden">
      <thead>
        <tr class="bg-slate-50 text-slate-500 text-xs uppercase tracking-wider border-b border-slate-200">
          <th class="w-[10%] px-4 py-5 font-bold">No. Panggil</th>
          <th class="w-[25%] px-4 py-5 font-bold">Judul</th>
          <th class="w-[25%] px-4 py-5 font-bold">Kreator</th>
          <th class="w-[15%] px-4 py-5 font-bold">Fisik</th>
          <th class="w-[15%] px-4 py-5 font-bold">Label</th>
          <th class="w-[10%] px-4 py-5 font-bold">Aksi</th>
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
          <td class="px-2 py-5 text-xs text-slate-600">
            <div class="truncate font-semibold">${audio.publisher!'-'}</div>
            <div class="text-slate-400">${audio.publishYear!'-'}</div>
          </td>
          <td class="px-2 py-5">
            <div class="flex justify-center gap-2 text-slate-400 text-xs font-bold">
              <button title="Play" class="hover:text-green-600 transition">Play</button>
              <a href="/admin/audio/edit/${audio.id}" class="hover:text-indigo-600 transition">Edit</a>
              <a href="/admin/audio/delete/${audio.id}" onclick="return confirm('Hapus?')" class="hover:text-red-500 transition">Del</a>
            </div>
          </td>
        </tr>
        </#list>
        <#else>
      <tr><td colspan="6" class="py-16 text-center text-slate-400 italic">Data belum tersedia.</td></tr>
      </#if>
      </tbody>
    </table>

      <#-- Paginasi Fungsional -->
      <div class="px-8 py-5 bg-slate-50 border-t border-slate-100 flex justify-between items-center text-slate-500 text-sm">
          <span>Menampilkan ${totalAudio} Rekaman</span>
          <div class="flex gap-2 items-center">
             <a href="?page=${(currentPage!1) - 1}" class="px-3 py-1 hover:bg-slate-200 rounded transition ${((currentPage!1) <= 1)?string('pointer-events-none opacity-50', '')}">Prev</a>
             <span class="px-3 py-1 bg-indigo-600 text-white rounded-lg shadow-sm font-medium">${currentPage!1}</span>
             <a href="?page=${(currentPage!1) + 1}" class="px-3 py-1 hover:bg-slate-200 rounded transition">Next</a>
          </div>
      </div>
    </div>
  </div>

</@layout.backofficeLayout>
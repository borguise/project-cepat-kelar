<#assign activePage = "agenda">
<#import "/layout/backoffice_layout.ftl" as layout>
<#assign totalAgenda = (eventList?size)!0>

<@layout.backofficeLayout title="Admin - Daftar Agenda" activePage=activePage adminName=adminName>

  <#if successMessage??>
    <div class="max-w-6xl w-full mx-auto px-4 mb-6">
      <div class="bg-green-50 border border-green-200 text-green-700 px-6 py-4 rounded-xl font-lato text-sm">${successMessage}</div>
    </div>
  </#if>
  <#if errorMessage??>
    <div class="max-w-6xl w-full mx-auto px-4 mb-6">
      <div class="bg-red-50 border border-red-200 text-red-700 px-6 py-4 rounded-xl font-lato text-sm">${errorMessage}</div>
    </div>
  </#if>

  <div class="max-w-6xl w-full mx-auto px-4 mb-6">
    <h2 class="text-3xl font-bold font-gelasio text-slate-800">Manajemen Kegiatan & Acara</h2>
  </div>

  <div class="flex justify-between items-center max-w-6xl w-full mx-auto px-4 mb-8 gap-4">
    <form action="/admin/events" method="GET" class="relative w-full max-w-xl">
      <input type="text" name="query" value="${(query)!''}" placeholder="Cari nama atau status kegiatan..." 
             class="w-full h-12 pl-6 pr-6 bg-white rounded-xl shadow-sm border border-slate-200 outline-none font-lato text-sm focus:border-indigo-300 focus:ring-1 focus:ring-indigo-300 transition-all">
      <button type="submit" class="absolute right-4 top-3.5 text-slate-400 hover:text-indigo-600 transition font-semibold text-sm">Cari</button>
    </form>
    
    <a href="/admin/events/new" class="h-12 bg-[#bef264] text-slate-900 px-7 flex items-center justify-center rounded-xl shadow-sm font-bold text-sm hover:bg-[#a3e635] transition-all active:scale-[0.98] whitespace-nowrap">
      + Tambah Kegiatan Baru
    </a>
  </div>

  <div class="w-full max-w-6xl mx-auto px-4 mb-12">
    <div class="w-full bg-white rounded-2xl shadow-sm border border-slate-100 overflow-hidden">
      <table class="w-full border-collapse text-center">
        <thead>
          <tr class="font-lato text-slate-400 text-xs uppercase tracking-wider border-b border-slate-100 bg-slate-50/50">
            <th class="px-8 py-5 text-left font-semibold">Nama Kegiatan</th>
            <th class="px-4 py-5 font-semibold">Waktu</th>
            <th class="px-4 py-5 font-semibold">Tempat</th>
            <th class="px-4 py-5 font-semibold">Status</th>
            <th class="px-6 py-5 font-semibold">Aksi</th>
          </tr>
        </thead>
        <tbody class="font-lato text-slate-700 divide-y divide-slate-50">
          <#if eventList?? && (eventList?size > 0)>
            <#list eventList as event>
              <tr class="hover:bg-slate-50/80 transition-colors duration-200 h-20">
                <td class="px-8 py-4 text-left font-bold text-slate-800 leading-tight max-w-[300px] break-words">${event.name!""}</td>
                <td class="px-4 py-4 font-medium text-slate-600"><#if event.eventDate??>${event.eventDate?string('dd/MM/yyyy HH:mm')}<#else>-</#if></td>
                <td class="px-4 py-4 text-slate-600">${event.location!""}</td>
                <td class="px-4 py-4">
                  <span class="inline-flex px-3 py-1 rounded-full text-xs font-bold border 
                    <#if (event.status!"") == 'Disetujui'>bg-green-50 text-green-700 border-green-200<#else>bg-yellow-50 text-yellow-700 border-yellow-200</#if>">
                    ${event.status!"Diproses"}
                  </span>
                </td>
                <td class="px-6 py-4">
                  <div class="flex justify-center gap-4 text-slate-400">
                    <a href="/admin/events/edit/${event.id?c}" title="Edit" class="hover:text-indigo-600 transition">
                      <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z"/></svg>
                    </a>
                    <a href="/admin/events/delete/${event.id?c}" onclick="return confirm('Hapus agenda: ${event.name}?')" title="Hapus" class="hover:text-red-500 transition">
                      <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/></svg>
                    </a>
                  </div>
                </td>
              </tr>
            </#list>
          <#else>
            <tr>
              <td colspan="5" class="py-16 text-center italic text-slate-400">Belum ada agenda kegiatan tersedia.</td>
            </tr>
          </#if>
        </tbody>
      </table>

      <div class="px-8 py-5 bg-slate-50 border-t border-slate-100 flex justify-between items-center text-slate-500 text-sm">
          <span>Menampilkan ${totalAgenda} Data Agenda</span>
          <div class="flex gap-2 items-center">
            <button class="px-3 py-1 hover:bg-slate-200 rounded transition">Prev</button>
            <span class="w-8 h-8 flex items-center justify-center bg-indigo-600 text-white rounded-lg shadow-sm font-medium">1</span>
            <button class="px-3 py-1 hover:bg-slate-200 rounded transition">Next</button>
          </div>
      </div>
    </div>
  </div> 

</@layout.backofficeLayout>
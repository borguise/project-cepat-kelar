<#assign activePage = "agenda">
<#import "/layout/backoffice_layout.ftl" as layout>
<#assign totalAgenda = (eventList?size)!0>
<@layout.backofficeLayout title="Admin - Daftar Agenda" activePage=activePage adminName=adminName>

      <#if successMessage??>
        <div class="max-w-6xl w-full mx-auto px-4">
          <div class="bg-green-100 border border-green-400 text-green-700 px-6 py-4 rounded-xl" role="alert">
            <span class="block sm:inline">${successMessage}</span>
          </div>
        </div>
      </#if>
      <#if errorMessage??>
        <div class="max-w-6xl w-full mx-auto px-4">
          <div class="bg-red-100 border border-red-400 text-red-700 px-6 py-4 rounded-xl" role="alert">
            <span class="block sm:inline">${errorMessage}</span>
          </div>
        </div>
      </#if>

      <div class="max-w-6xl w-full mx-auto px-4">
        <h2 class="text-4xl font-bold font-gelasio text-black italic leading-tight">Manajemen Kegiatan & Acara</h2>
      </div>

      <div class="flex justify-between items-center max-w-6xl w-full mx-auto px-4 gap-8">
          <form action="/admin/events" method="GET" class="relative w-[600px] h-12 bg-white rounded-xl shadow-lg flex items-center px-6 border border-stone-100">
            <input type="text" name="query" value="${(query)!''}" placeholder="Ketik Nama atau Status Kegiatan disini" class="w-full bg-transparent outline-none font-gelasio text-lg text-center text-black">
           <button type="submit" class="text-xl text-stone-400">🔍</button>
        </form>
        
        <a href="/admin/events/new" class="h-12 bg-[#bef264] text-indigo-900 px-8 flex items-center justify-center rounded-xl shadow-md font-bold text-base hover:bg-lime-400 transition-all active:scale-95 text-center">
          + Tambah Kegiatan Baru
        </a>
      </div>

      <div class="w-full max-w-6xl mx-auto bg-white rounded-3xl shadow-[0px_10px_30px_rgba(243,237,237,1.0)] border border-stone-100 overflow-hidden mb-12">
        <table class="w-full text-center border-collapse">
          <thead>
            <tr class="font-gelasio text-black text-xl border-b border-black/10 bg-slate-50/20">
              <th class="px-8 py-7 border-r border-black/10 text-left font-bold">Nama Kegiatan</th>
              <th class="px-4 py-7 border-r border-black/10 font-bold">Waktu</th>
              <th class="px-4 py-7 border-r border-black/10 font-bold">Tempat</th>
              <th class="px-4 py-7 border-r border-black/10 font-bold w-40">Status</th>
              <th class="px-6 py-7 font-bold w-36">Aksi</th>
            </tr>
          </thead>
          <tbody class="font-['Lato'] text-black text-base divide-y divide-black/10">
            <#if eventList?? && (eventList?size > 0)>
              <#list eventList as event>
                <tr class="hover:bg-slate-50 transition h-20">
                  <td class="px-8 border-r border-black/10 text-left font-bold leading-tight">${event.name!""}</td>
                  <td class="px-4 border-r border-black/10"><#if event.eventDate??>${event.eventDate?string('dd/MM/yyyy HH:mm')}<#else>-</#if></td>
                  <td class="px-4 border-r border-black/10">${event.location!""}</td>
                  <td class="px-4 border-r border-black/10">
                    <span class="px-3 py-1 rounded-full text-xs font-bold italic
                      <#if (event.status!"") == 'Disetujui'>text-green-600<#else>text-yellow-600</#if>">
                      ${event.status!"Diproses"}
                    </span>
                  </td>
                  <td class="px-4">
                    <div class="flex justify-center gap-6 text-2xl">
                      <a href="/admin/events/edit/${event.id?c}" title="Edit">✏️</a>
                      <a href="/admin/events/delete/${event.id?c}" onclick="return confirm('Hapus agenda: ${event.name}?')" title="Hapus">🗑️</a>
                    </div>
                  </td>
                </tr>
              </#list>
            <#else>
              <tr>
                <td colspan="5" class="py-20 text-center italic text-stone-400">Belum ada agenda kegiatan tersedia.</td>
              </tr>
            </#if>
          </tbody>
        </table>

        <div class="px-12 py-8 bg-slate-50 border-t border-black/10 flex justify-between items-center text-slate-500">
            <span>Menampilkan ${totalAgenda} Data Agenda</span>
            <div class="flex gap-4 items-center">
                <button class="hover:text-indigo-600 font-bold transition">« Sebelumnya</button>
                <div class="flex gap-2">
                    <span class="w-10 h-10 flex items-center justify-center bg-indigo-600 text-white rounded-lg shadow-md cursor-pointer">1</span>
                </div>
                <button class="hover:text-indigo-600 font-bold transition">Selanjutnya »</button>
            </div>
        </div>
      </div> 


</@layout.backofficeLayout>
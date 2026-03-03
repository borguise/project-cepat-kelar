<#assign activePage = "audio">
<#import "/layout/backoffice_layout.ftl" as layout>
<#assign totalAudio = (audioRecordings?size)!0>

<@layout.backofficeLayout title="Admin - Daftar Audio" activePage=activePage adminName=adminName>

      <div class="max-w-6xl w-full mx-auto px-4">
        <h2 class="text-4xl font-bold font-gelasio text-slate-800 italic">Daftar Rekaman Audio</h2>
      </div>

      <div class="flex justify-center items-center w-full gap-10">
        <form action="/admin/audio/search" method="GET" class="relative w-[500px] h-12 bg-white rounded-xl shadow-lg flex items-center px-8 border border-stone-100">
          <input type="text" name="query" placeholder="Ketik judul atau nomor panggil disini" class="w-full bg-transparent outline-none font-gelasio text-xl text-center text-black">
          <button type="submit" class="text-xl text-stone-400">🔍</button>
        </form>

        <a href="/admin/audio/new" class="h-12 bg-[#bef264] text-indigo-900 px-8 flex items-center justify-center rounded-xl shadow-md font-bold text-base hover:bg-lime-400 transition-all active:scale-95 whitespace-nowrap">
          + Tambah Rekaman Audio
        </a>
      </div>

      <div class="w-full max-w-6xl mx-auto bg-white rounded-3xl shadow-[0px_10px_30px_rgba(243,237,237,1.0)] border border-stone-100 overflow-hidden mb-12">
        <table class="w-full text-center border-collapse">
          <thead>
            <tr class="font-gelasio text-black text-xl border-b border-black/10 bg-slate-50/20">
              <th class="px-4 py-7 border-r border-black/10 font-bold w-40">Nomor Panggil</th>
              <th class="px-6 py-7 border-r border-black/10 font-bold">Judul & Kreator</th>
              <th class="px-4 py-7 border-r border-black/10 font-bold">Rincian Fisik</th>
              <th class="px-4 py-7 border-r border-black/10 font-bold w-32">Label</th>
              <th class="px-6 py-7 font-bold w-36">Aksi</th>
            </tr>
          </thead>
          <tbody class="font-['Lato'] text-base text-slate-700 divide-y divide-black/10">
            <#if audioRecordings?? && audioRecordings?size > 0>
              <#list audioRecordings as audio>
                <tr class="hover:bg-slate-50 transition h-20">
                  <td class="px-4 border-r border-black/10 font-bold italic text-stone-600">${audio.callNumber!''}</td>
                  <td class="px-6 border-r border-black/10 font-bold leading-tight text-stone-800">${audio.title!''}</td>
                  <td class="px-4 border-r border-black/10 text-stone-500 italic text-sm leading-tight">${audio.physicalDetails!''}</td>
                  <td class="px-4 border-r border-black/10 text-stone-500 font-bold">${audio.labelYear!''}</td>
                  <td class="px-4">
                    <div class="flex justify-center gap-5 text-2xl py-2">
                      <button title="Play" class="hover:scale-125 transition">▶️</button>
                      <a href="/admin/audio/edit/${audio.id}" title="Edit" class="hover:scale-125 transition">✏️</a>
                      <form action="/admin/audio/delete/${audio.id}" method="POST" onsubmit="return confirm('Hapus rekaman ini?')">
                        <button type="submit" title="Hapus" class="hover:scale-125 transition text-red-400">🗑️</button>
                      </form>
                    </div>
                  </td>
                </tr>
              </#list>
            <#else>
              <tr>
                <td colspan="5" class="py-20 text-stone-400 italic text-center">Belum ada data rekaman audio.</td>
              </tr>
            </#if>
          </tbody>
        </table>

        <div class="px-12 py-8 bg-slate-50 border-t border-black/10 flex justify-between items-center text-slate-500">
          <span>Menampilkan ${totalAudio} Rekaman Audio</span>
          <div class="flex gap-4 items-center">
            <button class="hover:text-indigo-600 font-bold transition">« Sebelumnya</button>
            <div class="flex gap-2 text-sm">
              <span class="w-10 h-10 flex items-center justify-center bg-indigo-600 text-white rounded-lg shadow-md cursor-pointer">1</span>
            </div>
            <button class="hover:text-indigo-600 font-bold transition">Selanjutnya »</button>
          </div>
        </div>
      </div>

</@layout.backofficeLayout>
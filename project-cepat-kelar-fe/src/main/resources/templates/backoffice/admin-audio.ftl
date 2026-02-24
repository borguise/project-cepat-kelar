<#assign activePage = "audio">
<#import "/layout/backoffice_layout.ftl" as layout>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Manajemen Audio | ${institutionName!"Graha Pusat Literasi"}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Lato:wght@400;700&family=Gelasio:ital,wght@0,400;0,700;1,400&display=swap" rel="stylesheet">
    <style>
        html, body { height: 100vh; width: 100vw; margin: 0; padding: 0; overflow: hidden; }
        body { font-family: 'Lato', sans-serif; display: flex; }
        .font-gelasio { font-family: 'Gelasio', serif; }
        .no-scrollbar::-webkit-scrollbar { display: none; }

        /* Custom Scrollbar */
        .scroll-indah::-webkit-scrollbar { width: 10px; display: block; }
        .scroll-indah::-webkit-scrollbar-track { background: #f1f5f9; border-radius: 10px; }
        .scroll-indah::-webkit-scrollbar-thumb { background: #cbd5e1; border: 2px solid #f1f5f9; border-radius: 10px; }
        .scroll-indah::-webkit-scrollbar-thumb:hover { background: #94a3b8; }

        /* Style Tabel */
        .table-pro { border-collapse: separate; border-spacing: 0; width: 100%; }
        .table-pro th, .table-pro td { 
            border-bottom: 1px solid #e2e8f0; 
            border-right: 1px solid #e2e8f0;  
            padding: 1.25rem 1rem; 
        }
        .table-pro th:last-child, .table-pro td:last-child { border-right: none; }
        .table-pro tr:last-child td { border-bottom: none; }
    </style>
</head>
<body class="bg-[#f8fafc]">

  <@layout.backofficeSidebar activePage=activePage />

  <main class="flex-1 ml-60 flex flex-col h-full overflow-hidden">
    
    <@layout.backofficeHeader adminName=(user.role!"Pustakawan") />

    <div class="flex-1 min-h-0 overflow-y-auto p-12 bg-slate-50/50 flex flex-col gap-10 scroll-indah">      
    
      <div class="max-w-6xl w-full mx-auto px-4 text-center">
        <h2 class="text-4xl font-bold font-gelasio text-black italic">Manajemen Rekaman Audio</h2>
      </div>

      <div class="flex justify-center items-center w-full gap-10">
        <form action="/admin/audio/search" method="GET" class="relative w-[450px] h-12 bg-white rounded-xl shadow-lg flex items-center px-8 border border-stone-100">
           <input type="text" name="query" placeholder="Ketik Judul atau Kreator disini" class="w-full bg-transparent outline-none font-gelasio text-lg text-center text-black">
           <button type="submit" class="text-xl text-stone-400">🔍</button>
        </form>
        
        <a href="/admin/audio/new" class="h-12 bg-[#bef264] text-indigo-900 px-8 flex items-center justify-center rounded-xl shadow-md font-bold text-base hover:bg-lime-400 transition-all active:scale-95 whitespace-nowrap">
          + Rekaman Audio Baru
        </a>
      </div>

      <div class="w-full max-w-6xl mx-auto bg-white rounded-3xl shadow-xl border border-slate-200 overflow-hidden mb-12 flex flex-col">
        <table class="table-pro font-lato text-center">
          <thead>
            <tr class="font-lato text-black text-xl bg-slate-50/50">
              <th class="font-bold w-36">Nomor Panggil</th>
              <th class="font-bold">Judul & Kreator</th>
              <th class="font-bold">Rincian Fisik</th>
              <th class="font-bold w-36">Label</th>
              <th class="font-bold w-40">Aksi</th>
            </tr>
          </thead>
          <tbody class="text-lg">
            <#if audioRecordings?? && audioRecordings?size > 0>
              <#list audioRecordings as audio>
                <tr class="hover:bg-slate-50 transition">
                  <td class="font-bold italic text-stone-600">${audio.callNumber}</td>
                  <td class="px-6 font-bold leading-tight text-stone-800">${audio.title}</td>
                  <td class="px-4 text-stone-500 italic text-base leading-tight">${audio.physicalDetails}</td>
                  <td class="text-stone-400 font-bold">${audio.labelYear}</td>
                  <td>
                    <div class="flex justify-center gap-6 text-3xl py-4">
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
                <td colspan="5" class="py-10 text-stone-400 italic text-center">Belum ada data rekaman audio.</td>
              </tr>
            </#if>
          </tbody>
        </table>

        <div class="px-12 py-8 bg-white border-t rounded-b-3xl flex justify-between items-center text-slate-500 font-bold">
            <span class="italic font-medium text-slate-400 font-gelasio text-sm">Menampilkan rekaman audio perpustakaan</span>
            <div class="flex gap-4 items-center">
                <button class="hover:text-indigo-600 transition px-5 py-2 rounded-full hover:bg-slate-50">« Sebelumnya</button>
                <div class="flex gap-2 text-sm">
                    <span class="w-10 h-10 flex items-center justify-center bg-indigo-600 text-white rounded-full shadow-md cursor-pointer font-lato">1</span>
                </div>
                <button class="hover:text-indigo-600 transition px-5 py-2 rounded-full hover:bg-slate-50">Selanjutnya »</button>
            </div>
        </div>
      </div> 

    </div>
  </main>
</body>
</html>
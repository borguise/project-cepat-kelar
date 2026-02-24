<#assign activePage = "voting">
<#import "/layout/backoffice_layout.ftl" as layout>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Pemilihan & Voting | ${institutionName!"Graha Pusat Literasi"}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Lato:wght@400;700&family=Gelasio:ital,wght@0,400;0,700;1,400&display=swap" rel="stylesheet">
    <style>
        /* [TRIPLE LOCK] Struktur identik dengan adminaudio.ftl & adminkoleksi.ftl */
        html, body { height: 100vh; width: 100vw; margin: 0; padding: 0; overflow: hidden; }
        body { font-family: 'Lato', sans-serif; display: flex; background-color: #f8fafc; }
        .font-gelasio { font-family: 'Gelasio', serif; }
        .no-scrollbar::-webkit-scrollbar { display: none; }

        /* Custom Scrollbar Indikator */
        .scroll-indah::-webkit-scrollbar { width: 8px; display: block; }
        .scroll-indah::-webkit-scrollbar-track { background: transparent; }
        .scroll-indah::-webkit-scrollbar-thumb { background: #cbd5e1; border-radius: 20px; border: 2px solid #f8fafc; }

        /* Gaya Tabel Dinamis */
        .table-voting { border-collapse: separate; border-spacing: 0; width: 100%; }
        .table-voting th, .table-voting td { 
            border-bottom: 1px solid #e2e8f0; 
            border-right: 1px solid #e2e8f0;  
            padding: 1.25rem 1rem; 
            text-align: center;
        }
        .table-voting th:last-child, .table-voting td:last-child { border-right: none; }
        .table-voting tr:last-child td { border-bottom: none; }
    </style>
</head>
<body>

  <@layout.backofficeSidebar activePage=activePage />

  <main class="flex-1 ml-60 flex flex-col h-full overflow-hidden">
    
    <@layout.backofficeHeader adminName=(user.role!"Pustakawan") />

    <div class="flex-1 overflow-y-auto p-12 bg-slate-50/50 flex flex-col gap-10 scroll-indah">      
      
      <div class="max-w-6xl w-full mx-auto px-4">
        <h2 class="text-4xl font-bold font-gelasio text-slate-800 italic">Daftar Pemilihan & Voting</h2>
      </div>

      <div class="flex justify-center items-center w-full gap-10">
        <form action="/admin/voting/search" method="GET" class="relative w-[500px] h-12 bg-white rounded-xl shadow-lg flex items-center px-8 border border-stone-100">
           <input type="text" name="query" placeholder="Ketik Judul atau Kategori disini" class="w-full bg-transparent outline-none font-gelasio text-xl text-center text-black">
           <button type="submit" class="text-xl text-stone-400">🔍</button>
        </form>
        
        <a href="/admin/voting/new" class="h-12 bg-[#bef264] text-indigo-900 px-8 flex items-center justify-center rounded-xl shadow-md font-bold text-base hover:bg-lime-400 transition-all active:scale-95 whitespace-nowrap">
          + Tambah Pemilihan Baru
        </a>
      </div>

      <div class="w-full max-w-6xl mx-auto bg-white rounded-3xl shadow-xl border border-slate-200 mb-12">
        <table class="table-voting font-lato">
          <thead>
            <tr class="text-black text-lg bg-slate-50/50 font-bold">
              <th class="w-1/4">Nama Pemilihan</th>
              <th>Periode</th>
              <th>Partisipan</th>
              <th>Status</th>
              <th class="w-32">Aksi</th>
            </tr>
          </thead>
          <tbody class="text-base text-slate-700">
            <#if votingList?? && votingList?size > 0>
              <#list votingList as vote>
                <tr class="hover:bg-slate-50 transition">
                  <td class="font-medium text-black">${vote.name}</td>
                  <td class="italic text-slate-500">${vote.periodStart} - ${vote.periodEnd}</td>
                  <td class="font-bold">${vote.participantCount!0}</td>
                  <td class="<#if vote.status == 'Aktif'>text-indigo-600 font-bold<#else>italic text-slate-400</#if>">
                    ${vote.status}
                  </td>
                  <td>
                    <div class="flex justify-center gap-5 text-2xl py-2">
                      <a href="/admin/voting/result/${vote.id}" title="Lihat Hasil" class="hover:scale-125 transition">👁️</a>
                      <form action="/admin/voting/delete/${vote.id}" method="POST" onsubmit="return confirm('Hapus pemilihan ini?')">
                        <button type="submit" title="Hapus" class="hover:scale-125 transition text-red-400">🗑️</button>
                      </form>
                    </div>
                  </td>
                </tr>
              </#list>
            <#else>
              <tr>
                <td colspan="5" class="py-10 text-slate-400 italic">Belum ada data pemilihan yang dibuat.</td>
              </tr>
            </#if>
          </tbody>
        </table>

        <div class="px-12 py-8 bg-white border-t border-slate-100 flex justify-between items-center text-slate-500 font-bold rounded-b-3xl">
            <span class="italic font-medium text-slate-400 font-gelasio text-sm">Menampilkan data pemilihan Graha Pusat Literasi</span>
            <div class="flex gap-4 items-center">
                <button class="hover:text-indigo-600 transition text-sm px-5 py-2 rounded-full hover:bg-slate-50">« Sebelumnya</button>
                <div class="flex gap-2 text-sm">
                    <span class="w-10 h-10 flex items-center justify-center bg-indigo-600 text-white rounded-full shadow-md cursor-pointer font-lato">1</span>
                </div>
                <button class="hover:text-indigo-600 transition text-sm px-5 py-2 rounded-full hover:bg-slate-50">Selanjutnya »</button>
            </div>
        </div>
      </div> 

    </div>
  </main>
</body>
</html>
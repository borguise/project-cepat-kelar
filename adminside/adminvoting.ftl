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

  <aside class="w-60 bg-[#1e293b] text-stone-300 flex flex-col h-full flex-shrink-0 shadow-2xl z-50 rounded-br-2xl">
    <div class="h-28 flex items-center justify-center border-b border-slate-700/50 flex-shrink-0">
      <div class="w-16 h-16 bg-white rounded-full flex items-center justify-center overflow-hidden border-2 border-slate-600 shadow-lg">
        <img src="/images/logo.png" alt="Logo" class="w-full h-full object-cover">
      </div>
    </div>
    <nav class="flex-1 px-4 py-8 space-y-5 font-gelasio text-lg flex flex-col overflow-y-auto no-scrollbar text-stone-400">
      <a href="/admin/beranda" class="w-full py-2 text-center hover:text-white transition">Beranda</a>
      <a href="/admin/artikel" class="w-full py-2 text-center hover:text-white transition leading-tight">Artikel & Berita</a>
      <a href="/admin/komentar" class="w-full py-2 text-center hover:text-white transition">Komentar</a>
      <a href="/admin/sorotan" class="w-full py-2 text-center hover:text-white transition">Sorotan</a>
      <a href="/admin/agenda" class="w-full py-2 text-center hover:text-white transition leading-tight">Agenda Kegiatan</a>
      <a href="/admin/koleksi" class="w-full py-2 text-center hover:text-white transition">Koleksi Buku</a>
      <a href="/admin/audio" class="w-full py-2 text-center hover:text-white transition">Audio</a>
      <a href="#" class="w-full py-2 text-center text-white font-bold transition">Pemilihan / Voting</a>
    </nav>
  </aside>

  <main class="flex-1 flex flex-col h-full overflow-hidden">
    
    <header class="bg-white h-28 flex-shrink-0 flex justify-end items-center pr-8 shadow-sm border-b border-stone-100 rounded-br-2xl z-40">
      <div class="flex items-center gap-8 text-indigo-900 text-2xl font-gelasio">
        <span>Halo, ${user.role!"Pustakawan"}!</span>
        <div class="flex items-center gap-3 border-l-2 pl-8 border-slate-100 cursor-pointer group" onclick="location.href='/logout'">
          <span class="group-hover:text-red-600 transition font-bold text-xl">Keluar</span>
          <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 group-hover:text-red-600 transition" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
          </svg>
        </div>
      </div>
    </header>

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
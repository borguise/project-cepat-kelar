<#-- admin/koleksi.ftl -->
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Katalog Koleksi | Graha Pusat Literasi</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Lato:wght@400;700&family=Gelasio:ital,wght@0,400;0,700;1,400&display=swap" rel="stylesheet">
    <style>
        /* Tetap mempertahankan struktur Triple Lock agar tidak merusak scroll */
        html, body { height: 100vh; width: 100vw; margin: 0; padding: 0; overflow: hidden; }
        body { font-family: 'Lato', sans-serif; display: flex; }
        .font-gelasio { font-family: 'Gelasio', serif; }
        .no-scrollbar::-webkit-scrollbar { display: none; }
        .scroll-indah::-webkit-scrollbar { width: 10px; display: block; }
        .scroll-indah::-webkit-scrollbar-track { background: #f1f5f9; border-radius: 10px; }
        .scroll-indah::-webkit-scrollbar-thumb { background: #cbd5e1; border: 2px solid #f1f5f9; border-radius: 10px; }
        .scroll-indah::-webkit-scrollbar-thumb:hover { background: #94a3b8; }
        .table-pro { border-collapse: separate; border-spacing: 0; width: 100%; }
        .table-pro th, .table-pro td { border-bottom: 1px solid #e2e8f0; border-right: 1px solid #e2e8f0; padding: 1rem 1rem; }
        .table-pro th:last-child, .table-pro td:last-child { border-right: none; }
        .table-pro tr:last-child td { border-bottom: none; }
    </style>
</head>
<body class="bg-[#f8fafc]">

  <aside class="w-64 bg-[#1e293b] text-stone-300 flex flex-col h-full flex-shrink-0 shadow-2xl z-50 rounded-br-2xl">
    <div class="h-28 flex items-center justify-center border-b border-slate-700/50 flex-shrink-0">
      <div class="w-16 h-16 bg-white rounded-full flex items-center justify-center overflow-hidden border-2 border-slate-600 shadow-lg">
        <img src="/images/logo-magetan.png" alt="Logo" class="w-full h-full object-cover">
      </div>
    </div>
     <nav class="flex-1 px-4 py-8 space-y-5 font-gelasio flex flex-col overflow-y-auto no-scrollbar">
      <a href="/admin/beranda" class="w-full py-2 text-center hover:text-white transition font-normal text-stone-400">Beranda</a>
      <a href="/admin/artikel" class="w-full py-2 text-center hover:text-white transition leading-tight text-stone-400">Artikel & Berita</a>
      <a href="/admin/komentar" class="w-full py-2 text-center hover:text-white transition text-stone-400">Komentar</a>
      <a href="/admin/sorotan" class="w-full py-2 text-center text-white font-bold transition">Sorotan</a>
      <a href="/admin/agenda" class="w-full py-2 text-center hover:text-white transition leading-tight text-stone-400">Agenda Kegiatan</a>
      <a href="/admin/koleksi" class="w-full py-2 text-center hover:text-white transition text-stone-400">Koleksi Buku</a>
      <a href="/admin/audio" class="w-full py-2 text-center hover:text-white transition text-stone-400">Audio</a>
      <a href="/admin/voting" class="w-full py-2 text-center hover:text-white transition text-base leading-tight text-stone-400">Pemilihan / Voting</a>
    </nav>
  </aside>

  <main class="flex-1 flex flex-col h-full overflow-hidden">
    <header class="bg-white h-28 flex-shrink-0 flex justify-end items-center pr-8 shadow-sm border-b border-stone-100 rounded-br-2xl z-40">
      <div class="flex items-center gap-8 text-indigo-900 text-2xl font-gelasio">
        <span>Halo, ${user.nama!"Pustakawan"}!</span>
        <form action="/logout" method="POST" class="flex items-center gap-3 border-l-2 pl-8 border-slate-100 cursor-pointer group">
          <button type="submit" class="group-hover:text-red-600 transition font-bold text-xl">Keluar</button>
          <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 group-hover:text-red-600 transition" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
          </svg>
        </form>
      </div>
    </header>

    <div class="flex-1 overflow-y-auto p-12 bg-slate-50/50 flex flex-col gap-8 scroll-indah">      
      <div class="max-w-6xl w-full mx-auto px-4">
        <h2 class="text-4xl font-bold font-gelasio text-black italic">Katalog Koleksi</h2>
      </div>

      <div class="flex justify-between items-center max-w-6xl w-full mx-auto px-4 gap-6">
        <div class="relative w-[500px] h-12 bg-white rounded-xl shadow-lg flex items-center px-6 border border-stone-100">
           <input type="text" placeholder="Ketik Judul, Pengarang..." class="w-full bg-transparent outline-none font-gelasio text-lg text-center text-black">
           <span class="text-xl text-stone-400">🔍</span>
        </div>

        <div id="filterContainer" onclick="toggleFilter(event)" class="relative w-56 h-12 bg-white rounded-xl shadow-lg flex items-center justify-between px-6 border border-stone-100 cursor-pointer">
           <span class="font-gelasio text-base text-black">Semua Kategori</span>
           <span class="text-xs">▼</span>
        </div>
        
        <a href="/admin/koleksi/tambah" class="h-12 bg-[#bef264] text-indigo-900 px-6 flex items-center justify-center rounded-xl shadow-md font-bold text-xs hover:bg-lime-400 transition-all active:scale-95 text-center leading-tight">
          + Tambah Buku Baru
        </a>
      </div>

      <div class="w-full max-w-6xl mx-auto bg-white rounded-2xl shadow-xl border border-slate-200">
        <table class="table-pro">
          <thead>
            <tr class="font-lato text-black text-lg bg-slate-50/50">
              <th class="font-bold text-center w-32">Nomor Panggil</th>
              <th class="font-bold text-center">Judul & Pengarang</th>
              <th class="font-bold text-center">Penerbit</th>
              <th class="font-bold text-center w-28">Stok</th>
              <th class="font-bold text-center w-32">Aksi</th>
            </tr>
          </thead>
          <tbody class="font-lato text-black text-sm text-center">
            <#-- MAPPING DATA BUKU DARI BACKEND -->
            <#list daftarBuku as buku>
              <tr class="hover:bg-slate-50 transition">
                <td class="font-bold">${buku.nomorPanggil}</td>
                <td class="px-6 leading-tight">${buku.judul} - ${buku.pengarang}</td>
                <td class="px-4 leading-tight">${buku.penerbit}, ${buku.tahunTerbit}</td>
                <td class="italic">${buku.stok} eks</td>
                <td>
                  <div class="flex justify-center gap-6 text-xl">
                    <#-- Navigasi Edit menggunakan ID dinamis -->
                    <a href="/admin/koleksi/edit/${buku.id}" class="hover:scale-110 transition">✏️</a>
                    <a href="/admin/koleksi/hapus/${buku.id}" onclick="return confirm('Hapus buku ini?')" class="hover:scale-110 transition">🗑️</a>
                  </div>
                </td>
              </tr>
            </#list>
          </tbody>
        </table>

        <div class="px-12 py-6 bg-white border-t border-slate-100 flex justify-between items-center text-slate-500 font-bold rounded-b-2xl">
            <span class="italic font-medium text-slate-400 font-gelasio text-sm">Menampilkan ${daftarBuku?size} Koleksi</span>
            <div class="flex gap-4 items-center">
                <#-- Logika Paginasi bisa ditambahkan di sini -->
                <button class="hover:text-indigo-600 transition">Sebelumnya</button>
                <button class="hover:text-indigo-600 transition">Selanjutnya</button>
            </div>
        </div>
      </div> 
    </div>
  </main>

  <script>
    fetch('/admin/koleksi/overlay')
      .then(response => response.text())
      .then(data => {
        document.getElementById('filterContainer').insertAdjacentHTML('beforeend', data);
      });

    function toggleFilter(e) {
      e.stopPropagation();
      const overlay = document.getElementById('filterOverlay');
      if (overlay) overlay.classList.toggle('hidden');
    }

    window.onclick = function(event) {
      const overlay = document.getElementById('filterOverlay');
      if (overlay && !event.target.closest('#filterContainer')) {
        overlay.classList.add('hidden');
      }
    }
  </script>
</body>
</html>
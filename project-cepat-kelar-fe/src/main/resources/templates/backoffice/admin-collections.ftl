<#-- admin/koleksi.ftl -->
<#assign activePage = "koleksi">
<#import "/layout/backoffice_layout.ftl" as layout>
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

  <@layout.backofficeSidebar activePage=activePage />

  <main class="flex-1 ml-60 flex flex-col h-full overflow-hidden">
    <@layout.backofficeHeader adminName=(user.nama!"Pustakawan") />

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
        
        <a href="/admin/collections/new" class="h-12 bg-[#bef264] text-indigo-900 px-6 flex items-center justify-center rounded-xl shadow-md font-bold text-xs hover:bg-lime-400 transition-all active:scale-95 text-center leading-tight">
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
                    <a href="/admin/collections/edit/${buku.id}" class="hover:scale-110 transition">✏️</a>
                    <a href="/admin/collections/delete/${buku.id}" onclick="return confirm('Hapus buku ini?')" class="hover:scale-110 transition">🗑️</a>
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
    fetch('/admin/collections/overlay')
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
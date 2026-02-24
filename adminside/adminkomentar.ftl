<#-- 1. Penanda Halaman Aktif -->
<#assign activePage = "komentar">

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Moderasi Komentar</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Lato:wght@400;700&family=Gelasio:ital,wght@0,400;0,700;1,400&display=swap" rel="stylesheet">
    <style>
        /* [TRIPLE LOCK 1] Kunci Body agar aplikasi pas di monitor */
        html, body { height: 100vh; width: 100vw; margin: 0; padding: 0; overflow: hidden; }
        body { font-family: 'Lato', sans-serif; display: flex; }
        .font-gelasio { font-family: 'Gelasio', serif; }
        .no-scrollbar::-webkit-scrollbar { display: none; }
    </style>
</head>
<body class="bg-[#f8fafc]">

  <aside class="w-60 bg-[#1e293b] text-stone-300 flex flex-col h-full flex-shrink-0 shadow-2xl z-50">
    <div class="pt-12 pb-8 flex justify-center border-b border-slate-700/50">
      <div class="w-20 h-20 bg-white rounded-full flex items-center justify-center overflow-hidden border-2 border-slate-600 shadow-lg">
        <img src="/images/logo-perpustakaan.png" alt="Logo" class="w-full h-full object-cover">
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
    
    <header class="bg-white h-28 flex-shrink-0 flex justify-end items-center px-16 shadow-md border-b border-stone-200 z-40">
      <div class="flex items-center gap-10 text-indigo-900 text-2xl font-gelasio">
        <span>Halo, ${adminName!"Pustakawan"}!</span>
        <div class="flex items-center gap-4 border-l-2 pl-10 border-slate-100 cursor-pointer group">
          <a href="/logout" class="group-hover:text-red-600 transition">Keluar</a>
        </div>
      </div>
    </header>

    <div class="flex-1 overflow-y-auto p-12 bg-slate-50/50 flex flex-col gap-10">
      
      <div class="max-w-6xl w-full mx-auto px-4">
        <h2 class="text-3xl font-bold font-gelasio text-black italic">Moderasi Komentar Artikel & Berita</h2>
      </div>

      <div class="w-full max-w-2xl mx-auto relative group">
        <input type="text" placeholder="Ketik Sumber Komentar disini" 
               class="w-full py-4 px-10 bg-white rounded-xl shadow-[0px_4px_15px_rgba(0,0,0,0.1)] border border-stone-100 outline-none font-gelasio text-2xl text-center">
      </div>

      <div class="w-full max-w-6xl mx-auto bg-white rounded-3xl shadow-[0px_10px_30px_rgba(243,237,237,1.0)] border border-stone-100 overflow-hidden mb-12 flex flex-col">
        <table class="w-full text-center border-collapse">
          <thead>
            <tr class="font-gelasio text-black text-xl border-b border-black bg-slate-50/20">
              <th class="px-4 py-8 border-r border-black/10 w-48 font-bold">Pengirim</th>
              <th class="px-4 py-8 border-r border-black/10 w-40 font-bold">Tanggal</th>
              <th class="px-4 py-8 border-r border-black/10 font-bold">Isi Pesan</th>
              <th class="px-4 py-8 border-r border-black/10 w-48 font-bold">Sumber</th>
              <th class="px-4 py-8 border-r border-black/10 w-44 font-bold">Status</th>
              <th class="px-6 py-8 font-bold">Aksi</th>
            </tr>
          </thead>
          <tbody class="font-['Lato'] text-black text-base divide-y divide-black/10">
            
            <#-- LOGIKA LOOPING DATA DARI DATABASE -->
            <#if comments?? && comments?size gt 0>
              <#list comments as c>
                <tr class="h-28 hover:bg-slate-50 transition" id="row-${c.id}">
                  <td class="px-4 border-r border-black/10 font-bold">${c.pengirim}</td>
                  <td class="px-4 border-r border-black/10 font-bold">${c.tanggal}</td>
                  <td class="px-6 border-r border-black/10 text-sm italic font-bold text-left">${c.isiPesan}</td>
                  <td class="px-4 border-r border-black/10 text-xs">${c.sumber}</td>
                  <td class="px-4 border-r border-black/10 font-bold status-text <#if c.status == 'Disembunyikan'>text-red-500<#else>text-green-600</#if>">
                    ${c.status}
                  </td>
                  <td class="px-4">
                    <div class="flex justify-center gap-4">
                      <#-- Tombol Mata Berubah Sesuai Status Awal -->
                      <button onclick="toggleEye(${c.id})" class="w-12 h-12 bg-slate-100 rounded-xl flex items-center justify-center hover:bg-indigo-600 hover:text-white transition">
                        <span class="eye-icon text-xl">
                          <#if c.status == "Disembunyikan">👁️‍🗨️<#else>👁️</#if>
                        </span>
                      </button>
                      <button onclick="confirmDelete(${c.id})" class="w-12 h-12 bg-slate-100 rounded-xl flex items-center justify-center hover:bg-red-600 transition">🗑️</button>
                    </div>
                  </td>
                </tr>
              </#list>
            <#else>
              <tr>
                <td colspan="6" class="py-20 text-center italic text-stone-400">Belum ada komentar masuk.</td>
              </tr>
            </#if>

          </tbody>
        </table>

        <div class="px-12 py-8 bg-slate-50 border-t border-black/10 flex justify-between items-center text-slate-500">
            <span>Menampilkan ${(comments?size)!0} Komentar</span>
            <div class="flex gap-4 items-center">
                <button class="hover:text-indigo-600 font-bold transition">« Sebelumnya</button>
                <div class="flex gap-2">
                    <span class="w-10 h-10 flex items-center justify-center bg-indigo-600 text-white rounded-lg shadow-md cursor-pointer">1</span>
                </div>
                <button class="hover:text-indigo-600 font-bold transition">Selanjutnya »</button>
            </div>
        </div>
      </div>

    </div>
  </main>

  <script>
    function toggleEye(id) {
        // Di sini nanti kamu hubungkan ke API Java untuk update status di database
        const row = document.getElementById('row-' + id);
        const icon = row.querySelector('.eye-icon');
        const statusText = row.querySelector('.status-text');

        if (statusText.innerText.trim() === "Disembunyikan") {
            icon.innerText = "👁️";
            statusText.innerText = "Tampil";
            statusText.classList.replace('text-red-500', 'text-green-600');
        } else {
            icon.innerText = "👁️‍🗨️";
            statusText.innerText = "Disembunyikan";
            statusText.classList.replace('text-green-600', 'text-red-500');
        }
    }

    function confirmDelete(id) {
        if(confirm("Hapus komentar ini?")) {
            window.location.href = "/admin/komentar/hapus/" + id;
        }
    }
  </script>
</body>
</html>
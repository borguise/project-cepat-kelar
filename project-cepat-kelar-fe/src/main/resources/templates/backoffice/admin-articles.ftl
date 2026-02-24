<#-- 1. Penanda Halaman Aktif untuk Sidebar -->
<#assign activePage = "artikel">
<#import "/layout/backoffice_layout.ftl" as layout>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Daftar Artikel & Berita</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Lato:wght@400;700&family=Gelasio:ital,wght@0,400;0,700;1,400&display=swap" rel="stylesheet">
    <style>
        /* [TRIPLE LOCK 1] Kunci Body */
        html, body { height: 100vh; width: 100vw; margin: 0; padding: 0; overflow: hidden; }
        body { font-family: 'Lato', sans-serif; display: flex; }
        .font-gelasio { font-family: 'Gelasio', serif; }
        .no-scrollbar::-webkit-scrollbar { display: none; }
    </style>
</head>
<body class="bg-[#f8fafc]">

  <@layout.backofficeSidebar activePage=activePage />

  <main class="flex-1 ml-60 flex flex-col h-full overflow-hidden">
    
    <@layout.backofficeHeader adminName=adminName />

    <div class="flex-1 overflow-y-auto p-12 bg-slate-50/50 flex flex-col gap-10">
      
      <div class="flex justify-between items-end max-w-6xl w-full mx-auto px-4">
        <h2 class="text-3xl font-bold font-gelasio text-black italic">Daftar Artikel & Berita</h2>
        <a href="/admin/articles/new" class="bg-[#bef264] text-white px-8 py-3 rounded-xl shadow-lg font-bold text-sm transition-all transform active:scale-95">
          + Tambah Artikel Baru
        </a>
      </div>

      <div class="w-full max-w-2xl mx-auto relative">
        <input type="text" name="search" placeholder="Ketik Judul atau Kategori disini" 
               class="w-full py-4 px-10 bg-white rounded-xl shadow-[0px_4px_15px_rgba(0,0,0,0.1)] border border-stone-100 outline-none font-gelasio text-2xl text-center focus:ring-2 focus:ring-indigo-100">
      </div>

      <div class="w-full max-w-6xl mx-auto bg-white rounded-3xl shadow-[0px_10px_30px_rgba(243,237,237,1.0)] border border-stone-100 overflow-hidden mb-20">
        <table class="w-full text-center border-collapse">
          <thead>
            <tr class="font-gelasio text-black text-xl border-b border-black">
              <th class="px-8 py-8 border-r border-black/10 w-[40%] font-bold">Judul Artikel</th>
              <th class="px-8 py-8 border-r border-black/10 font-bold">Kategori</th>
              <th class="px-8 py-8 border-r border-black/10 font-bold">Tanggal</th>
              <th class="px-6 py-8 font-bold">Aksi</th>
            </tr>
          </thead>
          <tbody class="font-['Lato'] text-black text-lg divide-y divide-black/10">
            
            <#-- LOGIKA LOOPING: Mengulang baris secara otomatis sesuai data database -->
            <#if articles?? && articles?size gt 0>
              <#list articles as art>
                <tr class="h-28 hover:bg-slate-50 transition">
                  <td class="px-10 border-r border-black/10 text-center">${art.judul}</td>
                  <td class="px-4 border-r border-black/10 text-blue-600 font-bold">${art.kategori}</td>
                  <td class="px-4 border-r border-black/10 font-bold">${art.tanggalFormatted}</td>
                  <td class="px-4">
                    <div class="flex justify-center gap-6 items-center">
                      <#-- LINK DINAMIS: Mengirim ID unik ke halaman editor -->
                      <a href="/admin/articles/edit/${art.id}" title="Edit" class="w-12 h-12 bg-indigo-600 text-white rounded-xl flex items-center justify-center shadow hover:bg-indigo-800 transition">
                        ✏️
                      </a>
                      <button onclick="confirmDelete(${art.id})" title="Delete" class="w-12 h-12 bg-slate-400 text-white rounded-xl flex items-center justify-center shadow hover:bg-red-600 transition">
                        🗑️
                      </button>
                    </div>
                  </td>
                </tr>
              </#list>
            <#else>
              <tr>
                <td colspan="4" class="py-20 text-center italic text-stone-400">Belum ada artikel yang tersedia.</td>
              </tr>
            </#if>

          </tbody>
        </table>

        <div class="px-12 py-8 bg-slate-50 border-t border-black/10 flex justify-between items-center text-slate-500">
            <span>Menampilkan ${articles?size} Artikel</span>
            <div class="flex gap-4 items-center">
                <#-- Logika paginasi sederhana -->
                <button class="hover:text-indigo-600 font-bold">« Sebelumnya</button>
                <div class="flex gap-2">
                    <span class="w-10 h-10 flex items-center justify-center bg-indigo-600 text-white rounded-lg cursor-pointer">1</span>
                    <span class="w-10 h-10 flex items-center justify-center hover:bg-indigo-100 rounded-lg cursor-pointer transition">2</span>
                </div>
                <button class="hover:text-indigo-600 font-bold">Selanjutnya »</button>
            </div>
        </div>
      </div>

    </div>
  </main>

  <script>
    function confirmDelete(id) {
        if(confirm("Apakah Anda yakin ingin menghapus artikel ini?")) {
            window.location.href = "/admin/articles/delete/" + id;
        }
    }
  </script>

</body>
</html>
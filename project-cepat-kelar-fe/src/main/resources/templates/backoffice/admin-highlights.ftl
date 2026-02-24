<#assign activePage = "sorotan">
<#import "/layout/backoffice_layout.ftl" as layout>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Sorotan | Graha Pusat Literasi</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Lato:wght@400;700&family=Gelasio:ital,wght@0,400;0,700;1,400&display=swap" rel="stylesheet">
    <style>
        /* [TRIPLE LOCK] Menjamin Sidebar & Header tetap diam */
        html, body { height: 100vh; width: 100vw; margin: 0; padding: 0; overflow: hidden; }
        body { font-family: 'Lato', sans-serif; display: flex; }
        .font-gelasio { font-family: 'Gelasio', serif; }

        /* CUSTOM SCROLLBAR: Indikator area bisa digulir */
        .scroll-indah::-webkit-scrollbar {
            width: 10px;
            display: block;
        }
        .scroll-indah::-webkit-scrollbar-track {
            background: #f1f5f9;
            border-radius: 10px;
        }
        .scroll-indah::-webkit-scrollbar-thumb {
            background: #cbd5e1;
            border: 2px solid #f1f5f9;
            border-radius: 10px;
        }
        .scroll-indah::-webkit-scrollbar-thumb:hover {
            background: #94a3b8;
        }

        /* Gaya Tabel Normal & Elegan (Garis Vertikal & Horizontal) */
        .table-pro { border-collapse: separate; border-spacing: 0; width: 100%; }
        .table-pro th, .table-pro td { 
            border-bottom: 1px solid #e2e8f0; 
            border-right: 1px solid #e2e8f0;  
            padding: 1.5rem 1rem;
        }
        .table-pro th:last-child, .table-pro td:last-child { border-right: none; }
        .table-pro tr:last-child td { border-bottom: none; }

        .rounded-table-tl { border-top-left-radius: 1rem; }
        .rounded-table-tr { border-top-right-radius: 1rem; }
    </style>
</head>
<body class="bg-[#f8fafc]">

  <@layout.backofficeSidebar activePage=activePage />

  <main class="flex-1 ml-60 flex flex-col h-full overflow-hidden">
    
    <@layout.backofficeHeader adminName=adminName />

    <div class="flex-1 overflow-y-auto p-12 bg-slate-50/50 flex flex-col gap-10 scroll-indah">      
    
      <div class="max-w-6xl w-full mx-auto px-4">
        <h2 class="text-4xl font-bold font-gelasio text-black italic">Sorotan Pengguna</h2>
      </div>

      <div class="flex justify-between items-center max-w-6xl w-full mx-auto px-4 gap-8">
        <div class="relative w-[600px] h-12 bg-white rounded-xl shadow-lg flex items-center px-6 border border-stone-100">
           <input type="text" placeholder="Ketik Judul atau Kategori disini" class="w-full bg-transparent outline-none font-gelasio text-lg text-center text-black">
           <span class="text-xl text-stone-400">🔍</span>
        </div>
        
        <a href="/admin/highlights/new" class="h-12 bg-[#bef264] text-indigo-900 px-8 flex items-center justify-center rounded-xl shadow-md font-bold text-base hover:bg-lime-400 transition-all active:scale-95 text-center">
          + Tambah Sorotan baru
        </a>
      </div>

      <div class="w-full max-w-6xl mx-auto bg-white rounded-2xl shadow-xl border border-slate-200">
        <table class="table-pro">
          <thead>
            <tr class="font-lato text-black text-xl bg-slate-50/50">
              <th class="text-left pl-12 rounded-table-tl">Judul / Pertanyaan</th>
              <th class="font-bold text-center">Urutan</th>
              <th class="font-bold text-center rounded-table-tr">Aksi</th>
            </tr>
          </thead>
          <tbody class="font-lato text-black text-lg">
            <#if sorotanList?? && (sorotanList?size > 0)>
              <#list sorotanList as item>
                <tr class="hover:bg-slate-50 transition">
                  <td class="text-left pl-12 font-bold leading-tight">${item.pertanyaan!""}/td>
                  <td class="text-center font-normal">Nomor ${item.urutan!0}</td>
                  <td class="text-center">
                    <div class="flex justify-center gap-6 text-2xl">
                      <a href="/admin/highlights/edit/${item.id}" title="Edit">✏️</a>
                      <a href="/admin/highlights/delete/${item.id}" title="Hapus" onclick="return confirm('Hapus data ini?')">🗑️</a>
                    </div>
                  </td>
                </tr>
              </#list>
            <#else>
              <tr>
                <td colspan="3" class="py-20 text-center text-slate-400 italic">Belum ada data sorotan tersedia.</td>
              </tr>
            </#if>
          </tbody>
        </table>

        <div class="px-12 py-8 bg-white border-t border-slate-100 flex justify-between items-center text-slate-500 font-bold rounded-b-2xl">
            <span class="italic font-medium text-slate-400 font-gelasio">Menampilkan ${(sorotanList?size)!0} Data Sorotan</span>
            <div class="flex gap-4 items-center">
                <button class="hover:text-indigo-600 transition">« Sebelumnya</button>
                <div class="flex gap-2">
                    <span class="w-10 h-10 flex items-center justify-center bg-indigo-600 text-white rounded-xl shadow-md cursor-pointer font-lato">1</span>
                </div>
                <button class="hover:text-indigo-600 transition">Selanjutnya »</button>
            </div>
        </div>
      </div> 

    </div>
  </main>

</body>
</html>
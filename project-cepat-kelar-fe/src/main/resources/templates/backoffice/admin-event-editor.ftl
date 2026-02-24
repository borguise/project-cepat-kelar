<#assign activePage = "agenda">
<#import "/layout/backoffice_layout.ftl" as layout>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Editor Agenda | Graha Pusat Literasi</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Lato:wght@400;700&family=Gelasio:ital,wght@0,400;0,700;1,400&display=swap" rel="stylesheet">
    <style>
        /* [TRIPLE LOCK] Sidebar & Header tetap diam, area konten bisa digulir */
        html, body { height: 100vh; width: 100vw; margin: 0; padding: 0; overflow: hidden; }
        body { font-family: 'Lato', sans-serif; display: flex; }
        .font-gelasio { font-family: 'Gelasio', serif; }
        .no-scrollbar::-webkit-scrollbar { display: none; }

        /* Custom Scrollbar Indikator */
        .scroll-indah::-webkit-scrollbar { width: 8px; display: block; }
        .scroll-indah::-webkit-scrollbar-track { background: #f1f5f9; border-radius: 10px; }
        .scroll-indah::-webkit-scrollbar-thumb { background: #cbd5e1; border-radius: 10px; }
        
        textarea:focus, input:focus { outline: none; }
    </style>
</head>
<body class="bg-[#f8fafc]">

  <@layout.backofficeSidebar activePage=activePage />

  <main class="flex-1 ml-60 flex flex-col h-full overflow-hidden">
    
    <@layout.backofficeHeader adminName=adminName />

    <div class="flex-1 overflow-y-auto p-12 bg-slate-50/50 flex flex-col gap-10 scroll-indah">      
    
      <div class="max-w-4xl w-full mx-auto px-4">
        <h2 class="text-4xl font-bold font-gelasio text-black italic">Tambah Agenda Baru</h2>
      </div>

      <form action="/admin/events/save" method="POST" enctype="multipart/form-data" 
            class="w-full max-w-4xl mx-auto bg-white rounded-3xl shadow-xl p-12 flex flex-col gap-8 mb-20 border border-stone-100">
        
        <div class="flex flex-col gap-3 text-center">
          <label class="font-gelasio text-2xl text-black">Kegiatan</label>
          <input type="text" name="nama" placeholder="Tulis Judul disini" required
                 class="w-full py-4 border border-stone-200 rounded-xl px-8 font-lato text-xl text-indigo-800 text-center focus:ring-4 focus:ring-indigo-50 transition-all placeholder:text-stone-300">
        </div>

        <div class="flex flex-col gap-3 text-center">
          <label class="font-gelasio text-2xl text-black">Waktu</label>
          <input type="text" name="waktu" placeholder="Tanggal & Jam Acara" required
                 class="w-full py-4 border border-stone-200 rounded-xl px-8 font-lato text-xl text-indigo-800 text-center focus:ring-4 focus:ring-indigo-50 transition-all placeholder:text-stone-300">
        </div>

        <div class="flex flex-col gap-3 text-center">
          <label class="font-gelasio text-2xl text-black">Tempat</label>
          <input type="text" name="tempat" placeholder="Lokasi Acara" required
                 class="w-full py-4 border border-stone-200 rounded-xl px-8 font-lato text-xl text-indigo-800 text-center focus:ring-4 focus:ring-indigo-50 transition-all placeholder:text-stone-300">
        </div>

        <div class="flex flex-col gap-3 text-center">
          <label class="font-gelasio text-2xl text-black">Poster kegiatan</label>
          <label class="w-full py-10 border-2 border-dashed border-stone-200 rounded-2xl flex items-center justify-center cursor-pointer hover:bg-slate-50 transition">
            <span class="text-indigo-800 text-sm font-lato">Klik untuk upload gambar</span>
            <input type="file" name="poster" class="hidden">
          </label>
        </div>

        <div class="flex flex-col gap-3 text-center">
          <label class="font-gelasio text-2xl text-black">Deskripsi Kegiatan</label>
          <textarea id="autoExpand" name="deskripsi" placeholder="Keterangan" required
                    oninput="this.style.height = ''; this.style.height = this.scrollHeight + 'px'"
                    class="w-full min-h-[160px] py-12 border border-stone-200 rounded-2xl px-10 font-lato text-xl text-indigo-800 text-center focus:ring-4 focus:ring-indigo-50 transition-all resize-none overflow-hidden placeholder:text-stone-300"></textarea>
        </div>

        <div class="flex justify-center mt-6">
          <button type="submit" class="bg-[#bef264] text-indigo-900 px-24 py-4 rounded-xl shadow-lg font-bold text-lg hover:bg-lime-400 transition-all active:scale-95">
            Publikasikan
          </button>
        </div>

      </form> 

    </div>
  </main>

  <script>
    // Memastikan tinggi textarea pas saat dimuat pertama kali
    const tx = document.getElementById('autoExpand');
    tx.setAttribute('style', 'height:' + (tx.scrollHeight) + 'px;overflow-y:hidden;');
  </script>

</body>
</html>
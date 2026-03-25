<#assign activePage = "sorotan">
<#import "/layout/backoffice_layout.ftl" as layout>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Editor | Graha Pusat Literasi</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Lato:wght@400;700&family=Gelasio:ital,wght@0,400;0,700;1,400&display=swap" rel="stylesheet">
    <style>
        html, body { height: 100vh; width: 100vw; margin: 0; padding: 0; overflow: hidden; }
        body { font-family: 'Lato', sans-serif; display: flex; }
        .font-gelasio { font-family: 'Gelasio', serif; }
        .no-scrollbar::-webkit-scrollbar { display: none; }

        .scroll-indah::-webkit-scrollbar { width: 8px; }
        .scroll-indah::-webkit-scrollbar-track { background: #f1f5f9; }
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
        <h2 class="text-4xl font-bold font-gelasio text-black">Tambah Sorotan Baru</h2>
      </div>

      <form action="/admin/highlights/save" method="POST" class="w-full max-w-4xl mx-auto bg-white rounded-3xl shadow-xl p-12 flex flex-col gap-8 mb-20 border border-stone-100">
        
        <div class="flex flex-col gap-3 text-center">
          <label class="font-gelasio text-2xl text-black">Judul</label>
          <input type="text" name="judul" placeholder="Tulis Judul disini" required
                 class="w-full py-4 border border-stone-200 rounded-xl px-8 font-lato text-xl text-indigo-800 text-center focus:ring-4 focus:ring-indigo-50 transition-all placeholder:text-stone-300">
        </div>

        <div class="flex flex-col gap-3 text-center">
          <label class="font-gelasio text-2xl text-black">Isi Konten</label>
          <textarea id="autoExpand" name="konten" placeholder="Isi Deskripsi" required
                    oninput="this.style.height = ''; this.style.height = this.scrollHeight + 'px'"
                    class="w-full min-h-[150px] py-12 border border-stone-200 rounded-2xl p-10 font-lato text-xl text-indigo-800 text-center focus:ring-4 focus:ring-indigo-50 transition-all resize-none overflow-hidden placeholder:text-stone-300"></textarea>
        </div>

        <div class="flex justify-center mt-4">
          <button type="submit" class="bg-[#bef264] text-indigo-900 px-24 py-4 rounded-xl shadow-lg font-bold text-lg hover:bg-lime-400 transition-all active:scale-95">
            Publikasikan
          </button>
        </div>

      </form> 

    </div>
  </main>

  <script>
    const tx = document.getElementById('autoExpand');
    tx.setAttribute('style', 'height:' + (tx.scrollHeight) + 'px;overflow-y:hidden;');
  </script>

</body>
</html>
<#-- Variabel ini biasanya dikirim dari Java Controller, misal: model.addAttribute("activePage", "artikel") -->
<#assign activePage = "artikel">

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Editor Artikel Literasi</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Lato&family=Gelasio&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Lato', sans-serif; }
        .font-gelasio { font-family: 'Gelasio', serif; }
        .no-scrollbar::-webkit-scrollbar { display: none; }
    </style>
</head>
<body class="bg-[#f8fafc] flex min-h-screen overflow-hidden">

  <aside class="w-60 bg-slate-800 text-stone-400 flex flex-col fixed h-full rounded-br-2xl shadow-xl z-50 overflow-hidden no-scrollbar">
    <div class="pt-10 pb-6 flex justify-center border-b border-slate-700/50">
      <div class="w-16 h-16 bg-gray-200 rounded-full overflow-hidden border-2 border-slate-600 shadow-md">
        <img src="/images/Ellipse 2.png" alt="Logo" class="w-full h-full object-cover">
      </div>
    </div>

    <nav class="flex-1 px-4 py-8 space-y-5 font-gelasio text-lg flex flex-col justify-start">
      <a href="/admin/beranda" class="block py-2 text-center transition-all hover:text-white 
         <#if activePage == 'beranda'>font-bold text-white<#else>font-normal text-stone-400</#if>">
        Beranda
      </a>

      <a href="/admin/artikel" class="block py-2 text-center transition-all hover:text-white 
         <#if activePage == 'artikel'>font-bold text-white<#else>font-normal text-stone-400</#if>">
        Artikel & Berita
      </a>

      <a href="/admin/komentar" class="block py-2 text-center transition-all hover:text-white 
         <#if activePage == 'komentar'>font-bold text-white<#else>font-normal text-stone-400</#if>">
        Komentar
      </a>

      <a href="/admin/sorotan" class="block py-2 text-center transition-all hover:text-white 
         <#if activePage == 'sorotan'>font-bold text-white<#else>font-normal text-stone-400</#if>">
        Sorotan
      </a>

      <a href="/admin/agenda" class="block py-2 text-center transition-all hover:text-white 
         <#if activePage == 'agenda'>font-bold text-white<#else>font-normal text-stone-400</#if>">
        Agenda Kegiatan
      </a>

      <a href="/admin/koleksi" class="block py-2 text-center transition-all hover:text-white 
         <#if activePage == 'koleksi'>font-bold text-white<#else>font-normal text-stone-400</#if>">
        Koleksi Buku
      </a>

      <a href="/admin/audio" class="block py-2 text-center transition-all hover:text-white 
         <#if activePage == 'audio'>font-bold text-white<#else>font-normal text-stone-400</#if>">
        Audio
      </a>

      <a href="/admin/voting" class="block py-2 text-center transition-all hover:text-white 
         <#if activePage == 'voting'>font-bold text-white<#else>font-normal text-stone-400</#if>">
        Pemilihan / Voting
      </a>
    </nav>
  </aside>

  <main class="flex-1 ml-60 flex flex-col overflow-hidden h-screen">
    
    <header class="bg-white h-28 flex-shrink-0 flex justify-end items-center px-12 shadow-sm border-b border-stone-200 rounded-br-2xl z-40">
      <div class="flex items-center gap-8">
        <span class="text-indigo-600 text-2xl font-gelasio">Halo, ${adminName!"Pustakawan"}!</span>
        <a href="/logout" class="flex items-center gap-3 group border-l pl-8 border-slate-200">
          <span class="text-indigo-800 text-xl font-gelasio group-hover:text-red-600 transition">Keluar</span>
          <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-indigo-800 group-hover:text-red-600 transition" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
          </svg>
        </a>
      </div>
    </header>

    <div class="flex-1 overflow-y-auto p-12">
      <div class="max-w-5xl mx-auto w-full">
        <h2 class="text-3xl font-bold mb-8 font-gelasio text-slate-800">
            <#if artikel??>Edit Artikel<#else>Tambah Artikel Baru</#if>
        </h2>
        
        <form action="/admin/artikel/simpan" method="POST" enctype="multipart/form-data" 
              class="bg-white p-12 rounded-2xl shadow-[0px_4px_10px_rgba(0,0,0,0.05)] space-y-10 border border-stone-100">
          
          <#if artikel??><input type="hidden" name="id" value="${artikel.id}"></#if>

          <div class="space-y-3">
              <label class="block text-2xl font-gelasio text-black">Judul</label>
              <input type="text" name="judul" value="${(artikel.judul)!''}" placeholder="Tulis Judul disini" required
                     class="w-full h-12 border border-gray-200 rounded-lg outline-none px-6 text-[#4338ca] text-xl font-['Lato'] focus:ring-2 focus:ring-indigo-500 transition">
          </div>

          <div class="space-y-3">
              <label class="block text-2xl font-gelasio text-black">Kategori</label>
              <input type="text" name="kategori" value="${(artikel.kategori)!''}" placeholder="Kategori konten" required
                     class="w-full h-12 border border-gray-200 rounded-lg outline-none px-6 text-[#4338ca] text-xl font-gelasio focus:ring-2 focus:ring-indigo-500 transition">
          </div>

          <div class="space-y-3">
              <label class="block text-2xl font-gelasio text-black">Gambar Sampul</label>
              <label for="upload-file" class="w-full h-40 border-2 border-dashed border-gray-200 rounded-lg flex items-center justify-center cursor-pointer hover:bg-gray-50 transition relative overflow-hidden group">
                  <img id="preview" src="<#if artikel?? && artikel.sampul??>/uploads/${artikel.sampul}<#else>#</#if>" 
                       class="<#if artikel?? && artikel.sampul??><#else>hidden</#if> absolute inset-0 w-full h-full object-cover">
                  <span id="label-text" class="text-indigo-400 group-hover:text-indigo-600 font-['Lato'] <#if artikel?? && artikel.sampul??>opacity-0</#if>">
                    Klik untuk upload gambar
                  </span>
                  <input type="file" id="upload-file" name="sampul" class="hidden" onchange="previewImage(event)">
              </label>
          </div>

          <div class="space-y-3">
              <label class="block text-2xl font-gelasio text-black">Isi Konten</label>
              <textarea name="isi" rows="10" placeholder="Mulai menulis artikel Anda..." 
                        class="w-full p-8 border border-gray-200 rounded-lg outline-none text-[#4338ca] text-xl font-['Lato'] focus:ring-2 focus:ring-indigo-500 resize-none leading-relaxed">${(artikel.isi)!''}</textarea>
          </div>

          <div class="flex justify-center pt-4">
               <button type="submit" class="bg-[#bef264] hover:bg-[#a3e635] text-slate-800 px-24 py-4 rounded-xl shadow-md transition-all font-bold text-xl font-['Lato'] transform hover:-translate-y-1">
                  <#if artikel??>Simpan Perubahan<#else>Publikasikan Artikel</#if>
               </button>
          </div>
        </form>
      </div>
    </div>
  </main>

  <script>
    function previewImage(event) {
        const reader = new FileReader();
        reader.onload = function() {
            const preview = document.getElementById('preview');
            const labelText = document.getElementById('label-text');
            preview.src = reader.result;
            preview.classList.remove('hidden');
            labelText.classList.add('opacity-0');
        }
        reader.readAsDataURL(event.target.files[0]);
    }
  </script>

</body>
</html>
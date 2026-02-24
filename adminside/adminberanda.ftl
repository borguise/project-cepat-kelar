<#-- Variabel activePage menandai bahwa ini adalah halaman beranda -->
<#assign activePage = "beranda">

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Graha Literasi Magetan</title>
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

    <div class="flex-1 overflow-y-auto p-10 flex flex-col items-center gap-10">
      
      <div class="w-full max-w-3xl bg-white py-4 px-8 rounded-xl shadow-sm text-center border border-stone-100">
        <h2 class="text-2xl text-indigo-800 font-gelasio mb-1 italic">Selamat datang pustakawan, salam literasi!</h2>
        <p class="text-indigo-800 text-base font-['Lato']">Kelola konten laman anda disini.</p>
      </div>

      <div class="flex gap-20 justify-center">
        <a href="/admin/artikel/tambah" class="w-52 bg-white py-2.5 rounded-xl shadow-sm text-center text-indigo-800 text-lg font-gelasio border border-indigo-50 hover:bg-indigo-50 transition">+ Tulis Artikel</a>
        <a href="/admin/agenda/update" class="w-52 bg-white py-2.5 rounded-xl shadow-sm text-center text-indigo-800 text-lg font-gelasio border border-indigo-50 hover:bg-indigo-50 transition">+ Perbaharui agenda</a>
      </div>

      <div class="flex gap-12 justify-center w-full">
        <a href="/admin/koleksi" class="w-32 h-44 bg-white rounded-2xl shadow-md flex flex-col items-center justify-center border border-stone-50 transition-all hover:scale-105 hover:shadow-lg">
          <span class="text-4xl font-gelasio text-black mb-4">${totalKoleksi!"0"}</span>
          <span class="text-xs font-gelasio text-gray-400 uppercase tracking-widest text-center">Judul<br>Koleksi</span>
        </a>
        
        <a href="/admin/artikel" class="w-32 h-44 bg-white rounded-2xl shadow-md flex flex-col items-center justify-center border border-stone-50 transition-all hover:scale-105 hover:shadow-lg">
          <span class="text-4xl font-gelasio text-black mb-4">${totalArtikel!"0"}</span>
          <span class="text-xs font-gelasio text-gray-400 uppercase tracking-widest text-center">Artikel<br>Terbit</span>
        </a>

        <a href="/admin/agenda" class="w-32 h-44 bg-white rounded-2xl shadow-md flex flex-col items-center justify-center border border-stone-50 transition-all hover:scale-105 hover:shadow-lg">
          <span class="text-4xl font-gelasio text-black mb-4">${totalAgenda!"0"}</span>
          <span class="text-xs font-gelasio text-gray-400 uppercase tracking-widest text-center">Agenda<br>Bulanan</span>
        </a>
      </div>

      <a href="/admin/artikel" class="w-full max-w-4xl bg-white p-8 rounded-xl shadow-sm border border-stone-100 block transition-all hover:bg-slate-50 hover:shadow-md">
        <div class="flex justify-center gap-12 text-indigo-800 text-xl font-gelasio items-center">
          <span class="font-bold uppercase tracking-tighter">Draft Belum selesai :</span>
          <div class="flex flex-row gap-6 text-base italic text-indigo-600">
             <#-- Daftar draft ini bisa dilooping jika datanya berupa List -->
             <span>1. E-perpusdamgt</span>
             <span>2. Kemah Literasi</span>
          </div>
        </div>
      </a>
    </div>
  </main>

</body>
</html>
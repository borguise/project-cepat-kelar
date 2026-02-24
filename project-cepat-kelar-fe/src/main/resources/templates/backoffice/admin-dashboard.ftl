<#-- Variabel activePage menandai bahwa ini adalah halaman beranda -->
<#assign activePage = "beranda">
<#import "/layout/backoffice_layout.ftl" as layout>

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

  <@layout.backofficeSidebar activePage=activePage />

  <main class="flex-1 ml-60 flex flex-col overflow-hidden h-screen">
    
    <@layout.backofficeHeader adminName=adminName />

    <div class="flex-1 overflow-y-auto p-10 flex flex-col items-center gap-10">
      
      <div class="w-full max-w-3xl bg-white py-4 px-8 rounded-xl shadow-sm text-center border border-stone-100">
        <h2 class="text-2xl text-indigo-800 font-gelasio mb-1 italic">Selamat datang pustakawan, salam literasi!</h2>
        <p class="text-indigo-800 text-base font-['Lato']">Kelola konten laman anda disini.</p>
      </div>

      <div class="flex gap-20 justify-center">
        <a href="/admin/articles/new" class="w-52 bg-white py-2.5 rounded-xl shadow-sm text-center text-indigo-800 text-lg font-gelasio border border-indigo-50 hover:bg-indigo-50 transition">+ Tulis Artikel</a>
        <a href="/admin/events/update" class="w-52 bg-white py-2.5 rounded-xl shadow-sm text-center text-indigo-800 text-lg font-gelasio border border-indigo-50 hover:bg-indigo-50 transition">+ Perbaharui agenda</a>
      </div>

      <div class="flex gap-12 justify-center w-full">
        <a href="/admin/collections" class="w-32 h-44 bg-white rounded-2xl shadow-md flex flex-col items-center justify-center border border-stone-50 transition-all hover:scale-105 hover:shadow-lg">
          <span class="text-4xl font-gelasio text-black mb-4">${totalKoleksi!"0"}</span>
          <span class="text-xs font-gelasio text-gray-400 uppercase tracking-widest text-center">Judul<br>Koleksi</span>
        </a>
        
        <a href="/admin/articles" class="w-32 h-44 bg-white rounded-2xl shadow-md flex flex-col items-center justify-center border border-stone-50 transition-all hover:scale-105 hover:shadow-lg">
          <span class="text-4xl font-gelasio text-black mb-4">${totalArtikel!"0"}</span>
          <span class="text-xs font-gelasio text-gray-400 uppercase tracking-widest text-center">Artikel<br>Terbit</span>
        </a>

        <a href="/admin/events" class="w-32 h-44 bg-white rounded-2xl shadow-md flex flex-col items-center justify-center border border-stone-50 transition-all hover:scale-105 hover:shadow-lg">
          <span class="text-4xl font-gelasio text-black mb-4">${totalAgenda!"0"}</span>
          <span class="text-xs font-gelasio text-gray-400 uppercase tracking-widest text-center">Agenda<br>Bulanan</span>
        </a>
      </div>

      <a href="/admin/articles" class="w-full max-w-4xl bg-white p-8 rounded-xl shadow-sm border border-stone-100 block transition-all hover:bg-slate-50 hover:shadow-md">
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
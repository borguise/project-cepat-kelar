<#macro backofficeSidebar activePage>
  <aside class="w-60 bg-slate-800 text-stone-400 flex flex-col fixed h-full rounded-br-2xl shadow-xl z-50 overflow-hidden no-scrollbar">
    <div class="pt-10 pb-6 flex justify-center border-b border-slate-700/50">
      <div class="w-16 h-16 bg-gray-200 rounded-full overflow-hidden border-2 border-slate-600 shadow-md">
        <img src="/images/backoffice/Ellipse 2.png" alt="Logo" class="w-full h-full object-cover">
      </div>
    </div>

    <#assign navItems = [
        {"key": "beranda", "label": "Beranda", "href": "/admin/dashboard"},
        {"key": "artikel", "label": "Artikel & Berita", "href": "/admin/articles"},
        {"key": "komentar", "label": "Komentar", "href": "/admin/comments"},
        {"key": "sorotan", "label": "Sorotan", "href": "/admin/highlights"},
        {"key": "agenda", "label": "Agenda Kegiatan", "href": "/admin/events"},
        {"key": "koleksi", "label": "Koleksi Buku", "href": "/admin/collections"},
        {"key": "audio", "label": "Audio", "href": "/admin/audio"},
        {"key": "voting", "label": "Pemilihan / Voting", "href": "/admin/voting"}
      ]>

    <nav class="flex-1 px-4 py-8 space-y-5 font-gelasio text-lg flex flex-col justify-start">
      <#list navItems as item>
        <a href="${item.href}" class="block py-2 text-center transition-all hover:text-white <#if (activePage!"") == item.key>font-bold text-white<#else>font-normal text-stone-400</#if>">
          ${item.label}
        </a>
      </#list>
    </nav>
  </aside>
</#macro>

<#macro backofficeHeader adminName>
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
</#macro>

<#macro backofficeLayout title activePage adminName>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${title!"Admin - Graha Literasi Magetan"}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Lato&family=Gelasio&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Lato', sans-serif; }
        .font-gelasio { font-family: 'Gelasio', serif; }
        .no-scrollbar::-webkit-scrollbar { display: none; }
    </style>
</head>
<body class="bg-[#f8fafc] flex min-h-screen overflow-hidden">

  <@backofficeSidebar activePage=activePage />

  <main class="flex-1 ml-60 flex flex-col overflow-hidden h-screen">

    <@backofficeHeader adminName=adminName />

    <div class="flex-1 overflow-y-auto p-10 flex flex-col items-center gap-10">
      <#nested>
    </div>
  </main>

</body>
</html>
</#macro>

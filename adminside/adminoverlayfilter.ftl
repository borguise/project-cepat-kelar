<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Lato:wght@400;700&display=swap" rel="stylesheet">
</head>
<body class="bg-transparent font-['Lato']">
<div id="filterOverlay" class="hidden absolute top-14 left-0 w-48 bg-white rounded-xl shadow-xl border border-slate-100 p-4 z-[100] flex flex-col gap-3">
  
  <label class="flex items-center gap-3 cursor-pointer group">
    <input type="checkbox" checked class="w-4 h-4 accent-indigo-600 rounded border-slate-300">
    <span class="font-lato text-sm font-bold text-black group-hover:text-indigo-600 transition">Semua</span>
  </label>

  <label class="flex items-center gap-3 cursor-pointer group border-t pt-2 border-slate-50">
    <input type="checkbox" class="w-4 h-4 accent-indigo-600 rounded border-slate-300">
    <span class="font-lato text-sm text-black group-hover:text-indigo-600 transition">Judul</span>
  </label>

  <label class="flex items-center gap-3 cursor-pointer group">
    <input type="checkbox" class="w-4 h-4 accent-indigo-600 rounded border-slate-300">
    <span class="font-lato text-sm text-black group-hover:text-indigo-600 transition">Pengarang</span>
  </label>

  <label class="flex items-center gap-3 cursor-pointer group">
    <input type="checkbox" class="w-4 h-4 accent-indigo-600 rounded border-slate-300">
    <span class="font-lato text-sm text-black group-hover:text-indigo-600 transition">No. Panggil</span>
  </label>

  <label class="flex items-center gap-3 cursor-pointer group">
    <input type="checkbox" class="w-4 h-4 accent-indigo-600 rounded border-slate-300">
    <span class="font-lato text-sm text-black group-hover:text-indigo-600 transition">Subjek</span>
  </label>

</div>
</body>
</html>
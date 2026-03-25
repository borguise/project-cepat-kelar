<#macro fallbackErrorPage statusCode errorTitle errorMessage path timestamp>
<#assign renderedTimestamp = "-">
<#if timestamp??>
  <#attempt>
    <#assign renderedTimestamp = timestamp?string("dd/MM/yyyy HH:mm:ss")>
  <#recover>
    <#attempt>
      <#assign renderedTimestamp = timestamp?string>
    <#recover>
      <#assign renderedTimestamp = "-">
    </#attempt>
  </#attempt>
</#if>
<!DOCTYPE html>
<html lang="id">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="icon" type="image/png" href="/images/backoffice/Ellipse 2.png">
  <title>${statusCode} - Terjadi Kesalahan</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link href="https://fonts.googleapis.com/css2?family=Gelasio:wght@700&family=Lato:wght@400;700&display=swap" rel="stylesheet">
  <style>
    body { font-family: 'Lato', sans-serif; }
    .font-gelasio { font-family: 'Gelasio', serif; }
  </style>
</head>
<body class="min-h-screen bg-slate-100 text-slate-800 flex items-center justify-center px-6">
  <div class="w-full max-w-2xl bg-white border border-slate-200 rounded-3xl shadow-lg p-10">
    <div class="inline-flex items-center gap-3 bg-red-50 border border-red-200 rounded-xl px-4 py-2 mb-6">
      <span class="text-red-700 font-bold">Error ${statusCode}</span>
    </div>

    <h1 class="font-gelasio text-4xl text-slate-900 mb-3">${errorTitle}</h1>
    <p class="text-lg text-slate-600 mb-8">${errorMessage}</p>

    <div class="bg-slate-50 border border-slate-200 rounded-2xl p-5 space-y-2 text-sm">
      <div><span class="font-bold">Path:</span> ${path!'-'}</div>
      <div><span class="font-bold">Waktu:</span> ${renderedTimestamp}</div>
    </div>

    <div class="mt-8 flex flex-wrap gap-3">
      <a href="/home" class="px-6 py-3 rounded-xl bg-indigo-700 text-white font-bold hover:bg-indigo-800 transition">Kembali ke Beranda</a>
      <a href="javascript:history.back()" class="px-6 py-3 rounded-xl bg-slate-200 text-slate-700 font-bold hover:bg-slate-300 transition">Kembali</a>
    </div>
  </div>
</body>
</html>
</#macro>

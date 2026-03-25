<#assign activePage = activePage!"beranda">
<#import "/layout/backoffice_layout.ftl" as layout>

<@layout.backofficeLayout title=((statusCode!500)?c + " - Terjadi Kesalahan") activePage=activePage adminName=adminName>
  <div class="w-full max-w-5xl mx-auto">
    <div class="bg-white rounded-3xl border border-red-200 shadow-md p-8 md:p-10">
      <div class="inline-flex items-center gap-2 bg-red-50 border border-red-200 rounded-lg px-4 py-2 mb-5">
        <span class="text-red-700 font-bold">Error ${(statusCode!500)?c}</span>
      </div>

      <h2 class="font-gelasio text-4xl text-slate-900 mb-3">${errorTitle!"Terjadi Kesalahan"}</h2>
      <p class="text-slate-600 text-lg mb-8">${errorMessage!"Sistem mengalami kendala. Silakan coba lagi."}</p>

      <div class="bg-slate-50 border border-slate-200 rounded-2xl p-5 space-y-2 text-sm text-slate-700">
        <div><span class="font-bold">Path:</span> ${path!"-"}</div>
        <div><span class="font-bold">Waktu:</span> ${timestamp!"-"}</div>
      </div>

      <div class="mt-8 flex gap-3 flex-wrap">
        <a href="javascript:history.back()" class="px-6 py-3 rounded-xl bg-indigo-700 text-white font-bold hover:bg-indigo-800 transition">Kembali</a>
        <a href="/admin/dashboard" class="px-6 py-3 rounded-xl bg-slate-200 text-slate-700 font-bold hover:bg-slate-300 transition">Ke Dashboard</a>
      </div>
    </div>
  </div>
</@layout.backofficeLayout>

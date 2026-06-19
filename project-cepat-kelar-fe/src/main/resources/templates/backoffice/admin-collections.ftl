<#-- admin/koleksi.ftl -->
<#assign activePage = "koleksi">
<#import "/layout/backoffice_layout.ftl" as layout>

<#-- Perhitungan totalKoleksi -->
<#assign totalKoleksi = (daftarBuku?? && daftarBuku?has_content)?then(daftarBuku?size, 0)>

<@layout.backofficeLayout title="Admin - Katalog Koleksi | Graha Pusat Literasi" activePage=activePage adminName=adminName>

  <div class="max-w-6xl w-full mx-auto px-4 mb-4">
    <h2 class="text-3xl font-bold font-gelasio text-slate-800">Katalog Koleksi</h2>
  </div>

  <#-- Notifikasi -->
  <#if successMessage??><div class="max-w-6xl w-full mx-auto px-4 mb-3"><div class="bg-green-50 border border-green-200 text-green-700 px-6 py-3 rounded-xl text-sm">${successMessage}</div></div></#if>
  <#if errorMessage??><div class="max-w-6xl w-full mx-auto px-4 mb-3"><div class="bg-red-50 border border-red-200 text-red-700 px-6 py-3 rounded-xl text-sm">${errorMessage}</div></div></#if>

  <div class="flex justify-between items-center max-w-6xl w-full mx-auto px-4 mb-5 gap-3">
    <form action="/admin/collections" method="GET" class="relative w-full max-w-xl">
      <input type="text" name="query" value="${query!''}" placeholder="Cari Judul, Pengarang, atau No. Panggil..." 
             class="w-full h-11 pl-6 pr-20 bg-white rounded-xl shadow-sm border border-slate-200 outline-none font-lato text-sm focus:border-indigo-300 focus:ring-1 focus:ring-indigo-300 transition-all">
      <button type="submit" class="absolute right-4 top-3 text-slate-400 hover:text-indigo-600 font-semibold text-sm">Cari</button>
    </form>

    <div id="filterContainer" class="relative w-48">
      <button onclick="toggleFilter(event)" class="w-full h-11 bg-white rounded-xl shadow-sm border border-slate-200 px-4 flex items-center justify-between font-gelasio text-sm text-slate-700">
        <span>Semua Kategori</span>
        <svg class="w-4 h-4 text-slate-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path></svg>
      </button>
      
      <div id="filterOverlay" class="hidden absolute top-12 left-0 w-full bg-white rounded-xl shadow-xl border border-slate-100 p-2 z-[100] flex flex-col gap-1">
        <a href="/admin/collections" class="px-4 py-2 hover:bg-indigo-50 rounded text-sm font-lato text-slate-700 transition">Semua</a>
        <a href="/admin/collections?cat=judul" class="px-4 py-2 hover:bg-indigo-50 rounded text-sm font-lato text-slate-700 transition">Judul</a>
        <a href="/admin/collections?cat=pengarang" class="px-4 py-2 hover:bg-indigo-50 rounded text-sm font-lato text-slate-700 transition">Pengarang</a>
        <a href="/admin/collections?cat=no_panggil" class="px-4 py-2 hover:bg-indigo-50 rounded text-sm font-lato text-slate-700 transition">No. Panggil</a>
        <a href="/admin/collections?cat=subjek" class="px-4 py-2 hover:bg-indigo-50 rounded text-sm font-lato text-slate-700 transition">Subjek</a>
      </div>
    </div>
    
    <a href="/admin/collections/new" class="h-11 bg-[#bef264] text-slate-900 px-6 flex items-center justify-center rounded-xl shadow-sm font-bold text-sm hover:bg-[#a3e635] transition-all whitespace-nowrap">
      + Tambah Buku
    </a>
  </div>

  <div class="w-full max-w-6xl mx-auto px-4 mb-6">
    <div class="w-full bg-white rounded-2xl shadow-sm border border-slate-100 overflow-x-auto">
      
      <#-- Tabel 6 Kolom Proporsional Rata Tengah -->
      <table class="w-full border-collapse table-fixed text-center">
        <thead>
          <tr class="bg-slate-50 text-slate-500 text-xs uppercase tracking-wider border-b border-slate-200">
            <th class="w-[15%] px-4 py-5 font-bold text-center">No. Panggil</th>
            <th class="w-[25%] px-4 py-5 font-bold text-center">Judul</th>
            <th class="w-[20%] px-4 py-5 font-bold text-center">Pengarang</th>
            <th class="w-[15%] px-4 py-5 font-bold text-center">Penerbit</th>
            <th class="w-[10%] px-4 py-5 font-bold text-center">Stok</th>
            <th class="w-[15%] px-4 py-5 font-bold text-center">Aksi</th>
          </tr>
        </thead>
        <tbody class="bg-white divide-y divide-slate-100">
          <#if daftarBuku?? && (daftarBuku?size > 0)>
            <#list daftarBuku as buku>
              <tr class="hover:bg-slate-50 transition-colors duration-200">
                <td class="px-2 py-5 text-sm font-bold text-indigo-600 truncate text-center">${buku.callNumber!'-'}</td>
                <td class="px-4 py-5 text-sm font-bold text-slate-800 truncate text-center" title="${buku.title!''}">${buku.title!'-'}</td>
                <td class="px-4 py-5 text-sm text-slate-600 truncate text-center" title="${buku.author!''}">${buku.author!'-'}</td>
                <td class="px-2 py-5 text-sm text-slate-500 truncate text-center">${buku.publisher!'-'}</td>
                <td class="px-2 py-5 text-sm font-medium text-slate-700 text-center">${(buku.stock!0)}</td>
                <td class="px-2 py-5">
                  <div class="flex justify-center items-center gap-3 text-slate-400 text-xs font-bold">
                    <a href="/admin/collections/edit/${buku.id}" class="hover:text-indigo-600 transition">Edit</a>
                    <a href="/admin/collections/delete/${buku.id}" onclick="return confirm('Hapus buku ini?')" class="hover:text-red-500 transition">Delete</a>
                  </div>
                </td>
              </tr>
            </#list>
          <#else>
            <tr><td colspan="6" class="py-16 text-center text-slate-400 italic">Belum ada data koleksi tersedia.</td></tr>
          </#if>
        </tbody>
      </table>

      <div class="px-6 py-4 bg-slate-50 border-t border-slate-100 flex justify-between items-center text-slate-500 text-xs">
          <span>Menampilkan ${totalKoleksi} Data</span>
          <div class="flex gap-1 items-center">
             <a href="?page=${(currentPage!1) - 1}" class="px-2 py-1 hover:bg-slate-200 rounded transition ${((currentPage!1) <= 1)?string('pointer-events-none opacity-50', '')}">Prev</a>
             <span class="px-3 py-1 bg-indigo-600 text-white rounded-lg shadow-sm font-medium">${currentPage!1}</span>
             <a href="?page=${(currentPage!1) + 1}" class="px-2 py-1 hover:bg-slate-200 rounded transition">Next</a>
          </div>
      </div>

    </div>
  </div> 

  <script>
    function toggleFilter(event) {
        event.stopPropagation();
        document.getElementById('filterOverlay').classList.toggle('hidden');
    }
    window.onclick = function(event) {
        const overlay = document.getElementById('filterOverlay');
        const container = document.getElementById('filterContainer');
        if (overlay && !container.contains(event.target)) {
            overlay.classList.add('hidden');
        }
    }
  </script>
</@layout.backofficeLayout>
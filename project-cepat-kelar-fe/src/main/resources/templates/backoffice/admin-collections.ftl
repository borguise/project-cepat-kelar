<#-- admin/koleksi.ftl -->
<#assign activePage = "koleksi">
<#import "/layout/backoffice_layout.ftl" as layout>
<#assign totalKoleksi = (daftarBuku?size)!0>

<@layout.backofficeLayout title="Admin - Katalog Koleksi | Graha Pusat Literasi" activePage=activePage adminName=adminName>

      <div class="max-w-6xl w-full mx-auto px-4">
        <h2 class="text-4xl font-bold font-gelasio text-black italic">Katalog Koleksi</h2>
      </div>

      <div class="flex justify-between items-center max-w-6xl w-full mx-auto px-4 gap-6">
        <div class="relative w-[500px] h-12 bg-white rounded-xl shadow-lg flex items-center px-6 border border-stone-100">
           <input type="text" placeholder="Ketik Judul, Pengarang..." class="w-full bg-transparent outline-none font-gelasio text-lg text-center text-black">
           <span class="text-xl text-stone-400">🔍</span>
        </div>

        <div id="filterContainer" onclick="toggleFilter(event)" class="relative w-56 h-12 bg-white rounded-xl shadow-lg flex items-center justify-between px-6 border border-stone-100 cursor-pointer">
           <span class="font-gelasio text-base text-black">Semua Kategori</span>
           <span class="text-xs">▼</span>

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
        </div>
        
        <a href="/admin/collections/new" class="h-12 bg-[#bef264] text-indigo-900 px-8 flex items-center justify-center rounded-xl shadow-md font-bold text-base hover:bg-lime-400 transition-all active:scale-95 text-center whitespace-nowrap">
          + Tambah Buku Baru
        </a>
      </div>

      <div class="w-full max-w-6xl mx-auto bg-white rounded-3xl shadow-[0px_10px_30px_rgba(243,237,237,1.0)] border border-stone-100 overflow-hidden mb-12">
        <table class="w-full text-center border-collapse table-fixed">
          <thead>
            <tr class="font-gelasio text-black text-xl border-b border-black/10 bg-slate-50/20">
              <th class="font-bold text-center w-32 px-4 py-7 border-r border-black/10">Nomor Panggil</th>
              <th class="font-bold text-center px-4 py-7 border-r border-black/10">Judul & Pengarang</th>
              <th class="font-bold text-center px-4 py-7 border-r border-black/10">Penerbit</th>
              <th class="font-bold text-center w-28 px-4 py-7 border-r border-black/10">Stok</th>
              <th class="font-bold text-center w-32 px-6 py-7">Aksi</th>
            </tr>
          </thead>
          <tbody class="font-['Lato'] text-black text-sm text-center divide-y divide-black/10">
            <#-- MAPPING DATA BUKU DARI BACKEND -->
            <#if daftarBuku?? && (daftarBuku?size > 0)>
              <#list daftarBuku as buku>
                <tr class="hover:bg-slate-50 transition h-20">
                  <td class="font-bold px-4 border-r border-black/10">${buku.nomorPanggil}</td>
                  <td class="px-6 leading-tight border-r border-black/10">${buku.judul} - ${buku.pengarang}</td>
                  <td class="px-4 leading-tight border-r border-black/10">${buku.penerbit}, ${buku.tahunTerbit}</td>
                  <td class="italic px-4 border-r border-black/10">${buku.stok} eks</td>
                  <td class="px-4">
                    <div class="flex justify-center gap-6 text-xl">
                      <#-- Navigasi Edit menggunakan ID dinamis -->
                      <a href="/admin/collections/edit/${buku.id}" class="hover:scale-110 transition">✏️</a>
                      <a href="/admin/collections/delete/${buku.id}" onclick="return confirm('Hapus buku ini?')" class="hover:scale-110 transition">🗑️</a>
                    </div>
                  </td>
                </tr>
              </#list>
            <#else>
              <tr>
                <td colspan="5" class="py-20 text-center text-slate-400 italic">Belum ada data koleksi tersedia.</td>
              </tr>
            </#if>
          </tbody>
        </table>

        <div class="px-12 py-8 bg-slate-50 border-t border-black/10 flex justify-between items-center text-slate-500">
          <span>Menampilkan ${totalKoleksi} Koleksi</span>
            <div class="flex gap-4 items-center">
                <#-- Logika Paginasi bisa ditambahkan di sini -->
                <button class="hover:text-indigo-600 font-bold transition">« Sebelumnya</button>
                <button class="hover:text-indigo-600 font-bold transition">Selanjutnya »</button>
            </div>
        </div>
      </div> 

  <script>
    function toggleFilter(e) {
      e.stopPropagation();
      const overlay = document.getElementById('filterOverlay');
      if (overlay) overlay.classList.toggle('hidden');
    }

    window.onclick = function(event) {
      const overlay = document.getElementById('filterOverlay');
      if (overlay && !event.target.closest('#filterContainer')) {
        overlay.classList.add('hidden');
      }
    }
  </script>

</@layout.backofficeLayout>
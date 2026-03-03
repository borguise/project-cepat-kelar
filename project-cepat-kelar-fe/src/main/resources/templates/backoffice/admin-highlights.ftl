<#assign activePage = "sorotan">
<#import "/layout/backoffice_layout.ftl" as layout>
<#assign totalSorotan = (sorotanList?size)!0>
<@layout.backofficeLayout title="Admin - Daftar Sorotan" activePage=activePage adminName=adminName>

      <div class="max-w-6xl w-full mx-auto px-4">
        <h2 class="text-4xl font-bold font-gelasio text-black italic">Sorotan Pengguna</h2>
      </div>

      <div class="flex justify-between items-center max-w-6xl w-full mx-auto px-4 gap-8">
        <div class="relative w-[600px] h-12 bg-white rounded-xl shadow-lg flex items-center px-6 border border-stone-100">
           <input type="text" placeholder="Ketik Judul atau Kategori disini" class="w-full bg-transparent outline-none font-gelasio text-lg text-center text-black">
           <span class="text-xl text-stone-400">🔍</span>
        </div>
        
        <a href="/admin/highlights/new" class="h-12 bg-[#bef264] text-indigo-900 px-8 flex items-center justify-center rounded-xl shadow-md font-bold text-base hover:bg-lime-400 transition-all active:scale-95 text-center">
          + Tambah Sorotan baru
        </a>
      </div>

      <div class="w-full max-w-6xl mx-auto bg-white rounded-3xl shadow-[0px_10px_30px_rgba(243,237,237,1.0)] border border-stone-100 overflow-hidden mb-12">
        <table class="w-full text-center border-collapse">
          <thead>
            <tr class="font-gelasio text-black text-xl border-b border-black/10 bg-slate-50/20">
              <th class="px-8 py-7 border-r border-black/10 text-left font-bold">Judul / Pertanyaan</th>
              <th class="px-4 py-7 border-r border-black/10 font-bold w-44">Urutan</th>
              <th class="px-6 py-7 font-bold w-36">Aksi</th>
            </tr>
          </thead>
          <tbody class="font-['Lato'] text-black text-base divide-y divide-black/10">
            <#if sorotanList?? && (sorotanList?size > 0)>
              <#list sorotanList as item>
                <tr class="hover:bg-slate-50 transition h-20">
                  <td class="px-8 border-r border-black/10 text-left font-bold leading-tight">${item.pertanyaan!""}</td>
                  <td class="px-4 border-r border-black/10 font-normal">Nomor ${item.urutan!0}</td>
                  <td class="px-4">
                    <div class="flex justify-center gap-6 text-2xl">
                      <a href="/admin/highlights/edit/${item.id}" title="Edit">✏️</a>
                      <a href="/admin/highlights/delete/${item.id}" title="Hapus" onclick="return confirm('Hapus data ini?')">🗑️</a>
                    </div>
                  </td>
                </tr>
              </#list>
            <#else>
              <tr>
                <td colspan="3" class="py-20 text-center italic text-stone-400">Belum ada data sorotan tersedia.</td>
              </tr>
            </#if>
          </tbody>
        </table>

        <div class="px-12 py-8 bg-slate-50 border-t border-black/10 flex justify-between items-center text-slate-500">
            <span>Menampilkan ${totalSorotan} Data Sorotan</span>
            <div class="flex gap-4 items-center">
                <button class="hover:text-indigo-600 font-bold transition">« Sebelumnya</button>
                <div class="flex gap-2">
                    <span class="w-10 h-10 flex items-center justify-center bg-indigo-600 text-white rounded-lg shadow-md cursor-pointer">1</span>
                </div>
                <button class="hover:text-indigo-600 font-bold transition">Selanjutnya »</button>
            </div>
        </div>
      </div> 


</@layout.backofficeLayout>
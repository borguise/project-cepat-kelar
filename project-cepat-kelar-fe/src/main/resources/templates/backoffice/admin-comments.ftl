<#-- 1. Penanda Halaman Aktif -->
<#assign activePage = "komentar">
<#import "/layout/backoffice_layout.ftl" as layout>

<@layout.backofficeLayout title="Admin - Moderasi Komentar" activePage=activePage adminName=adminName>
      
      <div class="max-w-6xl w-full mx-auto px-4">
        <h2 class="text-3xl font-bold font-gelasio text-black italic">Moderasi Komentar Artikel & Berita</h2>
      </div>

      <div class="w-full max-w-2xl mx-auto relative group">
        <form action="/admin/comments" method="GET">
          <input type="text" name="search" placeholder="Ketik Sumber Komentar disini" 
                 value="${searchKeyword!''}"
                 class="w-full py-4 px-10 bg-white rounded-xl shadow-[0px_4px_15px_rgba(0,0,0,0.1)] border border-stone-100 outline-none font-gelasio text-2xl text-center">
          <button type="submit" class="absolute right-6 top-1/2 -translate-y-1/2 text-indigo-600 hover:text-indigo-800 text-2xl">🔍</button>
        </form>
      </div>

      <div class="w-full max-w-6xl mx-auto bg-white rounded-3xl shadow-[0px_10px_30px_rgba(243,237,237,1.0)] border border-stone-100 overflow-hidden mb-12 flex flex-col">
        <table class="w-full text-center border-collapse">
          <thead>
            <tr class="font-gelasio text-black text-xl border-b border-black bg-slate-50/20">
              <th class="px-4 py-8 border-r border-black/10 w-48 font-bold">Pengirim</th>
              <th class="px-4 py-8 border-r border-black/10 w-40 font-bold">Tanggal</th>
              <th class="px-4 py-8 border-r border-black/10 font-bold">Isi Pesan</th>
              <th class="px-4 py-8 border-r border-black/10 w-48 font-bold">Sumber</th>
              <th class="px-4 py-8 border-r border-black/10 w-44 font-bold">Status</th>
              <th class="px-6 py-8 font-bold">Aksi</th>
            </tr>
          </thead>
          <tbody class="font-['Lato'] text-black text-base divide-y divide-black/10">
            
            <#-- LOGIKA LOOPING DATA DARI DATABASE -->
            <#if comments?? && comments?size gt 0>
              <#list comments as c>
                <tr class="h-28 hover:bg-slate-50 transition" id="row-${c.id}">
                  <td class="px-4 border-r border-black/10 font-bold">${c.sender}</td>
                  <td class="px-4 border-r border-black/10 font-bold">${c.commentDate}</td>
                  <td class="px-6 border-r border-black/10 text-sm italic font-bold text-left">${c.content}</td>
                  <td class="px-4 border-r border-black/10 text-xs">${c.source}</td>
                  <td class="px-4 border-r border-black/10 font-bold status-text <#if c.status == 'Hidden'>text-red-500<#else>text-green-600</#if>">
                    ${c.status}
                  </td>
                  <td class="px-4">
                    <div class="flex justify-center gap-4">
                      <#-- Tombol Mata Berubah Sesuai Status Awal -->
                      <button onclick="toggleEye(${c.id})" class="w-12 h-12 bg-slate-100 rounded-xl flex items-center justify-center hover:bg-indigo-600 hover:text-white transition">
                        <span class="eye-icon text-xl">
                          <#if c.status == "Hidden">👁️‍🗨️<#else>👁️</#if>
                        </span>
                      </button>
                      <button onclick="confirmDelete(${c.id})" class="w-12 h-12 bg-slate-100 rounded-xl flex items-center justify-center hover:bg-red-600 transition">🗑️</button>
                    </div>
                  </td>
                </tr>
              </#list>
            <#else>
              <tr>
                <td colspan="6" class="py-20 text-center italic text-stone-400">Belum ada komentar masuk.</td>
              </tr>
            </#if>

          </tbody>
        </table>

        <div class="px-12 py-8 bg-slate-50 border-t border-black/10 flex justify-between items-center text-slate-500">
            <span>Menampilkan ${(comments?size)!0} dari ${(totalItems)!0} Komentar</span>
            <div class="flex gap-4 items-center">
                <#if (currentPage!0) gt 0>
                    <a href="/admin/comments?page=${(currentPage!0) - 1}&size=10<#if searchKeyword??>&search=${searchKeyword}</#if>" 
                       class="hover:text-indigo-600 font-bold transition">« Sebelumnya</a>
                <#else>
                    <span class="text-gray-300 font-bold">« Sebelumnya</span>
                </#if>
                <div class="flex gap-2">
                    <#list 0..<(totalPages!1) as i>
                        <#if i == (currentPage!0)>
                            <span class="w-10 h-10 flex items-center justify-center bg-indigo-600 text-white rounded-lg shadow-md cursor-pointer">${i + 1}</span>
                        <#else>
                            <a href="/admin/comments?page=${i}&size=10<#if searchKeyword??>&search=${searchKeyword}</#if>" 
                               class="w-10 h-10 flex items-center justify-center bg-gray-200 text-gray-700 rounded-lg hover:bg-indigo-600 hover:text-white transition">${i + 1}</a>
                        </#if>
                    </#list>
                </div>
                <#if (currentPage!0) lt ((totalPages!1) - 1)>
                    <a href="/admin/comments?page=${(currentPage!0) + 1}&size=10<#if searchKeyword??>&search=${searchKeyword}</#if>" 
                       class="hover:text-indigo-600 font-bold transition">Selanjutnya »</a>
                <#else>
                    <span class="text-gray-300 font-bold">Selanjutnya »</span>
                </#if>
            </div>
        </div>
      </div>

  <script>
    function toggleEye(id) {
        // Call API to toggle status in database
        fetch('/admin/comments/toggle/' + id, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            }
        })
        .then(response => {
            if (response.ok) {
                return response.json();
            }
            throw new Error('Failed to toggle status');
        })
        .then(data => {
            const row = document.getElementById('row-' + id);
            const icon = row.querySelector('.eye-icon');
            const statusText = row.querySelector('.status-text');

            if (data.status === "Hidden") {
                icon.innerText = "👁️‍🗨️";
                statusText.innerText = "Hidden";
                statusText.classList.replace('text-green-600', 'text-red-500');
            } else {
                icon.innerText = "👁️";
                statusText.innerText = "Published";
                statusText.classList.replace('text-red-500', 'text-green-600');
            }
        })
        .catch(error => {
            alert('Gagal mengubah status komentar: ' + error.message);
        });
    }

    function confirmDelete(id) {
        if(confirm("Hapus komentar ini?")) {
            window.location.href = "/admin/comments/delete/" + id;
        }
    }
  </script>
</@layout.backofficeLayout>
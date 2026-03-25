<#assign activePage = "sorotan">
<#import "/layout/backoffice_layout.ftl" as layout>
<#assign currentStatus = "PUBLISHED">
<#if sorotan?? && sorotan.status?? && sorotan.status?has_content>
  <#assign currentStatus = sorotan.status>
</#if>
<@layout.backofficeLayout title="Admin - Editor Sorotan" activePage=activePage adminName=adminName>

      <div class="max-w-4xl w-full mx-auto px-4">
        <h2 class="text-4xl font-bold font-gelasio text-black italic"><#if sorotan??>Edit Sorotan<#else>Tambah Sorotan Baru</#if></h2>
      </div>

      <form action="/admin/highlights/save" method="POST" class="w-full max-w-4xl mx-auto bg-white rounded-3xl shadow-xl p-12 flex flex-col gap-8 mb-20 border border-stone-100">
        <input type="hidden" name="id" value="${(sorotan.id)!''}">
        
        <div class="flex flex-col gap-3 text-center">
          <label class="font-gelasio text-2xl text-black">Pertanyaan</label>
          <input type="text" name="question" value="${(sorotan.question)!''}" placeholder="Tulis pertanyaan disini" required
                 class="w-full py-4 border border-stone-200 rounded-xl px-8 font-lato text-xl text-indigo-800 text-center focus:ring-4 focus:ring-indigo-50 transition-all placeholder:text-stone-300">
        </div>

        <div class="flex flex-col gap-3 text-center">
          <label class="font-gelasio text-2xl text-black">Isi Konten</label>
          <textarea id="autoExpand" name="answer" placeholder="Isi jawaban" required
                    oninput="this.style.height = ''; this.style.height = this.scrollHeight + 'px'"
                    class="w-full min-h-[150px] py-12 border border-stone-200 rounded-2xl p-10 font-lato text-xl text-indigo-800 text-center focus:ring-4 focus:ring-indigo-50 transition-all resize-none overflow-hidden placeholder:text-stone-300">${(sorotan.answer)!''}</textarea>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
          <div class="flex flex-col gap-3 text-center">
            <label class="font-gelasio text-2xl text-black">Urutan Tampil</label>
            <input type="number" min="1" name="displayOrder" value="${(sorotan.displayOrder)!1}" required
                   class="w-full py-4 px-8 border border-stone-200 rounded-xl font-lato text-base text-indigo-800 text-center focus:ring-4 focus:ring-indigo-50 transition-all placeholder:text-stone-300 h-14" style="font-size: 16px;">
          </div>
          <div class="flex flex-col gap-3 text-center">
            <label class="font-gelasio text-2xl text-black">Status</label>
            <select name="status" class="w-full py-4 px-8 border border-stone-200 rounded-xl font-lato text-base text-indigo-800 text-center focus:ring-4 focus:ring-indigo-50 transition-all bg-white h-14 appearance-none cursor-pointer" style="font-size: 16px;">
              <option value="PUBLISHED" <#if currentStatus == 'PUBLISHED'>selected</#if>>Dipublikasikan</option>
              <option value="HIDDEN" <#if currentStatus == 'HIDDEN'>selected</#if>>Disembunyikan</option>
            </select>
          </div>
        </div>

        <div class="flex justify-center mt-6">
          <button type="submit" class="bg-[#bef264] text-indigo-900 px-24 py-4 rounded-xl shadow-lg font-bold text-lg hover:bg-lime-400 transition-all active:scale-95">
            <#if sorotan??>Simpan Perubahan<#else>Publikasikan</#if>
          </button>
        </div>

      </form> 

  <script>
    const tx = document.getElementById('autoExpand');
    tx.setAttribute('style', 'height:' + (tx.scrollHeight) + 'px;overflow-y:hidden;');
  </script>

</@layout.backofficeLayout>
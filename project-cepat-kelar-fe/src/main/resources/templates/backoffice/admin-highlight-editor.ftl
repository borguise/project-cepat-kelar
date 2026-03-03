<#assign activePage = "sorotan">
<#import "/layout/backoffice_layout.ftl" as layout>
<@layout.backofficeLayout title="Admin - Editor Sorotan" activePage=activePage adminName=adminName>

      <div class="max-w-4xl w-full mx-auto px-4">
        <h2 class="text-4xl font-bold font-gelasio text-black">Tambah Sorotan Baru</h2>
      </div>

      <form action="/admin/highlights/save" method="POST" class="w-full max-w-4xl mx-auto bg-white rounded-3xl shadow-xl p-12 flex flex-col gap-8 mb-20 border border-stone-100">
        
        <div class="flex flex-col gap-3 text-center">
          <label class="font-gelasio text-2xl text-black">Judul</label>
          <input type="text" name="judul" placeholder="Tulis Judul disini" required
                 class="w-full py-4 border border-stone-200 rounded-xl px-8 font-lato text-xl text-indigo-800 text-center focus:ring-4 focus:ring-indigo-50 transition-all placeholder:text-stone-300">
        </div>

        <div class="flex flex-col gap-3 text-center">
          <label class="font-gelasio text-2xl text-black">Isi Konten</label>
          <textarea id="autoExpand" name="konten" placeholder="Isi Deskripsi" required
                    oninput="this.style.height = ''; this.style.height = this.scrollHeight + 'px'"
                    class="w-full min-h-[150px] py-12 border border-stone-200 rounded-2xl p-10 font-lato text-xl text-indigo-800 text-center focus:ring-4 focus:ring-indigo-50 transition-all resize-none overflow-hidden placeholder:text-stone-300"></textarea>
        </div>

        <div class="flex justify-center mt-4">
          <button type="submit" class="bg-[#bef264] text-indigo-900 px-24 py-4 rounded-xl shadow-lg font-bold text-lg hover:bg-lime-400 transition-all active:scale-95">
            Publikasikan
          </button>
        </div>

      </form> 

  <script>
    const tx = document.getElementById('autoExpand');
    tx.setAttribute('style', 'height:' + (tx.scrollHeight) + 'px;overflow-y:hidden;');
  </script>

</@layout.backofficeLayout>
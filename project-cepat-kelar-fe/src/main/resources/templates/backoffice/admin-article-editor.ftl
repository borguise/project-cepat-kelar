<#-- Variabel ini biasanya dikirim dari Java Controller, misal: model.addAttribute("activePage", "artikel") -->
<#assign activePage = "artikel">
<#import "/layout/backoffice_layout.ftl" as layout>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Editor Artikel Literasi</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Lato&family=Gelasio&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Lato', sans-serif; }
        .font-gelasio { font-family: 'Gelasio', serif; }
        .no-scrollbar::-webkit-scrollbar { display: none; }
    </style>
</head>
<body class="bg-[#f8fafc] flex min-h-screen overflow-hidden">

  <@layout.backofficeSidebar activePage=activePage />

  <main class="flex-1 ml-60 flex flex-col overflow-hidden h-screen">
    
    <@layout.backofficeHeader adminName=adminName />

    <div class="flex-1 overflow-y-auto p-12">
      <div class="max-w-5xl mx-auto w-full">
        <h2 class="text-3xl font-bold mb-8 font-gelasio text-slate-800">
            <#if artikel??>Edit Artikel<#else>Tambah Artikel Baru</#if>
        </h2>
        
        <form action="/admin/articles/save" method="POST" enctype="multipart/form-data" 
              class="bg-white p-12 rounded-2xl shadow-[0px_4px_10px_rgba(0,0,0,0.05)] space-y-10 border border-stone-100">
          
          <#if artikel??><input type="hidden" name="id" value="${artikel.id}"></#if>

          <div class="space-y-3">
              <label class="block text-2xl font-gelasio text-black">Judul</label>
              <input type="text" name="judul" value="${(artikel.judul)!''}" placeholder="Tulis Judul disini" required
                     class="w-full h-12 border border-gray-200 rounded-lg outline-none px-6 text-[#4338ca] text-xl font-['Lato'] focus:ring-2 focus:ring-indigo-500 transition">
          </div>

          <div class="space-y-3">
              <label class="block text-2xl font-gelasio text-black">Kategori</label>
              <input type="text" name="kategori" value="${(artikel.kategori)!''}" placeholder="Kategori konten" required
                     class="w-full h-12 border border-gray-200 rounded-lg outline-none px-6 text-[#4338ca] text-xl font-gelasio focus:ring-2 focus:ring-indigo-500 transition">
          </div>

          <div class="space-y-3">
              <label class="block text-2xl font-gelasio text-black">Gambar Sampul</label>
              <label for="upload-file" class="w-full h-40 border-2 border-dashed border-gray-200 rounded-lg flex items-center justify-center cursor-pointer hover:bg-gray-50 transition relative overflow-hidden group">
                  <img id="preview" src="<#if artikel?? && artikel.sampul??>/uploads/${artikel.sampul}<#else>#</#if>" 
                       class="<#if artikel?? && artikel.sampul??><#else>hidden</#if> absolute inset-0 w-full h-full object-cover">
                  <span id="label-text" class="text-indigo-400 group-hover:text-indigo-600 font-['Lato'] <#if artikel?? && artikel.sampul??>opacity-0</#if>">
                    Klik untuk upload gambar
                  </span>
                  <input type="file" id="upload-file" name="sampul" class="hidden" onchange="previewImage(event)">
              </label>
          </div>

          <div class="space-y-3">
              <label class="block text-2xl font-gelasio text-black">Isi Konten</label>
              <textarea name="isi" rows="10" placeholder="Mulai menulis artikel Anda..." 
                        class="w-full p-8 border border-gray-200 rounded-lg outline-none text-[#4338ca] text-xl font-['Lato'] focus:ring-2 focus:ring-indigo-500 resize-none leading-relaxed">${(artikel.isi)!''}</textarea>
          </div>

          <div class="flex justify-center pt-4">
               <button type="submit" class="bg-[#bef264] hover:bg-[#a3e635] text-slate-800 px-24 py-4 rounded-xl shadow-md transition-all font-bold text-xl font-['Lato'] transform hover:-translate-y-1">
                  <#if artikel??>Simpan Perubahan<#else>Publikasikan Artikel</#if>
               </button>
          </div>
        </form>
      </div>
    </div>
  </main>

  <script>
    function previewImage(event) {
        const reader = new FileReader();
        reader.onload = function() {
            const preview = document.getElementById('preview');
            const labelText = document.getElementById('label-text');
            preview.src = reader.result;
            preview.classList.remove('hidden');
            labelText.classList.add('opacity-0');
        }
        reader.readAsDataURL(event.target.files[0]);
    }
  </script>

</body>
</html>
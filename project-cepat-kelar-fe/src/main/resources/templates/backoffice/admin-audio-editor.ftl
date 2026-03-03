<#assign activePage = "audio">
<#import "/layout/backoffice_layout.ftl" as layout>

<@layout.backofficeLayout title="Admin - Editor Audio | ${institutionName!'Graha Pusat Literasi'}" activePage=activePage adminName=adminName>

    <div class="w-full max-w-6xl mx-auto">      
      
      <div class="max-w-6xl w-full mx-auto px-4">
        <h2 class="text-3xl font-bold font-gelasio text-slate-800 italic">Editor Rekaman Audio</h2>
      </div>

      <form action="/admin/audio/save" method="POST" enctype="multipart/form-data" class="w-full max-w-6xl mx-auto bg-white rounded-3xl shadow-lg border border-slate-100 p-8 mb-8 flex flex-col gap-8">
        
        <input type="hidden" name="id" value="${(audio.id)!''}">

        <div class="flex flex-col lg:flex-row gap-10">
          <div class="flex-1 space-y-5">
            <h3 class="text-xl font-bold font-gelasio text-indigo-800 italic border-l-4 border-indigo-800 pl-3">I. Data Utama</h3>
            
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                    <label class="label-elegant">Nomor Panggil</label>
                    <input type="text" name="callNumber" value="${(audio.callNumber)!''}" placeholder="Nomor ddc" class="input-premium">
                </div>
                <div>
                    <label class="label-elegant">Subjek</label>
                    <input type="text" name="subject" value="${(audio.subject)!''}" placeholder="Materi audio" class="input-premium">
                </div>
                <div class="md:col-span-2">
                    <label class="label-elegant">Judul Rekaman</label>
                    <input type="text" name="title" value="${(audio.title)!''}" placeholder="Judul audio" class="input-premium">
                </div>
                <div class="md:col-span-2">
                    <label class="label-elegant">Pernyataan Tanggung Jawab</label>
                    <input type="text" name="responsibility" value="${(audio.responsibility)!''}" placeholder="Nama Pengisi suara" class="input-premium">
                </div>
                <div class="md:col-span-2">
                    <label class="label-elegant">General Material Designation</label>
                    <input type="text" name="gmd" value="${(audio.gmd)!''}" placeholder="[rekaman suara]" class="input-premium">
                </div>
            </div>
          </div>

          <div class="lg:w-56 flex flex-col items-center justify-center pt-8">
            <div class="w-52 h-64 bg-slate-50 border-2 border-dashed border-slate-200 rounded-2xl flex items-center justify-center cursor-pointer hover:bg-white hover:border-indigo-400 transition-all group overflow-hidden relative">
              <#if audio?? && audio.coverUrl?? && audio.coverUrl?has_content>
                <img src="${(audio.coverUrl)!''}" class="w-full h-full object-cover" onerror="this.classList.add('hidden')">
              <#else>
                <div class="text-center p-4">
                  <span class="block text-2xl mb-1 group-hover:scale-110 transition">🖼️</span>
                  <span class="text-indigo-800 font-bold font-lato text-xs">Unggah Cover</span>
                </div>
              </#if>
              <input type="file" name="coverFile" class="absolute inset-0 opacity-0 cursor-pointer">
            </div>
          </div>
        </div>

        <hr class="border-slate-50">

        <div class="space-y-5">
          <h3 class="text-xl font-bold font-gelasio text-indigo-800 italic border-l-4 border-indigo-800 pl-3">II. Data Penerbit</h3>
          <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
            <div>
              <label class="label-elegant">Label / Lembaga</label>
              <input type="text" name="publisher" value="${(audio.publisher)!''}" placeholder="Nama Penerbit" class="input-premium">
            </div>
            <div>
              <label class="label-elegant">Kota Asal</label>
              <input type="text" name="originCity" value="${(audio.originCity)!''}" placeholder="Daerah Terbit" class="input-premium">
            </div>
            <div>
              <label class="label-elegant">Tahun Terbit</label>
              <input type="text" name="publishYear" value="${(audio.publishYear)!''}" placeholder="Waktu Terbit" class="input-premium">
            </div>
          </div>
        </div>

        <hr class="border-slate-50">

        <div class="space-y-5">
          <h3 class="text-xl font-bold font-gelasio text-indigo-800 italic border-l-4 border-indigo-800 pl-3">III. Data Fisik</h3>
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label class="label-elegant">Jumlah dan Jenis Media</label>
              <input type="text" name="mediaType" value="${(audio.mediaType)!''}" placeholder="1 keping cd" class="input-premium">
            </div>
            <div>
              <label class="label-elegant">Detail dan Format Suara</label>
              <input type="text" name="audioFormat" value="${(audio.audioFormat)!''}" placeholder="mp3, mp4," class="input-premium">
            </div>
          </div>
        </div>

        <div class="flex justify-center pt-6 border-t border-slate-50">
          <button type="submit" class="bg-[#bef264] hover:bg-lime-400 text-indigo-900 font-bold px-24 py-4 rounded-2xl shadow-lg transition-all active:scale-95 text-xl font-lato">
            Simpan Rekaman Audio
          </button>
        </div>

      </form> 

    </div>

</@layout.backofficeLayout>
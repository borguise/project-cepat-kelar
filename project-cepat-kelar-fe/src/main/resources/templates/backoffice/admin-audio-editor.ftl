<#-- admin-audio-editor.ftl -->
<#assign activePage = "audio">
<#import "/layout/backoffice_layout.ftl" as layout>

<@layout.backofficeLayout title="Admin - Editor Audio | ${institutionName!'Graha Pusat Literasi'}" activePage=activePage adminName=adminName>

    <div class="w-full max-w-6xl mx-auto">      
      
      <div class="max-w-6xl w-full mx-auto px-4 mb-6">
        <h2 class="text-3xl font-bold font-gelasio text-slate-800 italic">Editor Rekaman Audio</h2>
      </div>

      <#if successMessage??>
        <div class="max-w-6xl w-full mx-auto px-4">
          <div class="bg-green-100 border border-green-400 text-green-700 px-6 py-4 rounded-xl" role="alert">
            <span class="block sm:inline">${successMessage}</span>
          </div>
        </div>
      </#if>
      <#if errorMessage??>
        <div class="max-w-6xl w-full mx-auto px-4">
          <div class="bg-red-100 border border-red-400 text-red-700 px-6 py-4 rounded-xl" role="alert">
            <span class="block sm:inline">${errorMessage}</span>
          </div>
        </div>
      </#if>

      <form id="audio-form" action="/admin/audio/save" method="POST" enctype="multipart/form-data" class="w-full max-w-6xl mx-auto bg-white rounded-3xl shadow-lg border border-slate-100 p-8 mb-8 flex flex-col gap-8">
        
        <input type="hidden" name="id" value="${(audio.id)!''}">
        <input type="hidden" name="coverImageBase64" id="audioCoverImageBase64" value="">
        <input type="hidden" name="coverFileName" id="audioCoverFileName" value="">

        <div class="flex flex-col lg:flex-row gap-8">
          <div class="flex-1 space-y-5">
            <h3 class="text-xl font-bold font-gelasio text-indigo-800 italic border-l-4 border-indigo-800 pl-3">Data Utama</h3>
            
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

          <div class="lg:w-56 flex flex-col items-center justify-center pt-6">
            <div class="w-52 h-64 bg-slate-50 border-2 border-dashed border-slate-200 rounded-2xl flex items-center justify-center cursor-pointer hover:bg-white hover:border-indigo-400 transition-all group overflow-hidden relative">
              <img id="audioCoverPreview" src="" class="w-full h-full object-cover hidden" alt="Preview cover audio">
              <#if coverUrl?? && coverUrl?has_content>
                <img id="audioExistingCover" src="${coverUrl}" class="w-full h-full object-cover" onerror="this.classList.add('hidden')">
              <#else>
                <div id="audioCoverPlaceholder" class="text-center p-4">
                  <span class="block text-2xl mb-1 group-hover:scale-110 transition">Image</span>
                  <span class="text-indigo-800 font-bold font-lato text-xs">Unggah Cover</span>
                </div>
              </#if>
              <input type="file" id="coverFileInput" name="coverFile" class="absolute inset-0 opacity-0 cursor-pointer" accept="image/*">
            </div>
          </div>
        </div>

        <hr class="border-slate-50">

        <!-- BAGIAN UPLOAD FILE AUDIO FISIK -->
        <div class="space-y-3">
          <h3 class="text-xl font-bold font-gelasio text-indigo-800 italic border-l-4 border-indigo-800 pl-3">File Audio (MP3 / WAV)</h3>
          <div class="bg-slate-50 p-6 rounded-2xl border border-slate-200 flex flex-col gap-3">
            <label class="label-elegant text-sm font-semibold text-slate-700">Pilih Berkas Suara dari Perangkat</label>
            <input type="file" name="audioFile" accept="audio/*" class="block w-full text-sm text-slate-500 file:mr-4 file:py-3 file:px-6 file:rounded-xl file:border-0 file:text-sm file:font-semibold file:bg-indigo-50 file:text-indigo-700 hover:file:bg-indigo-100 cursor-pointer">
            <p class="text-xs text-slate-400">Unggah file format .mp3 atau .wav agar dapat diputar langsung di pemutar utama pengunjung maupun admin.</p>
          </div>
        </div>

        <hr class="border-slate-50">

        <div class="space-y-5">
          <h3 class="text-xl font-bold font-gelasio text-indigo-800 italic border-l-4 border-indigo-800 pl-3">Data Penerbit</h3>
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
          <h3 class="text-xl font-bold font-gelasio text-indigo-800 italic border-l-4 border-indigo-800 pl-3"> Data Fisik</h3>
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

      <script>
        document.addEventListener('DOMContentLoaded', function() {
          const fileInput = document.getElementById('coverFileInput');
          const preview = document.getElementById('audioCoverPreview');
          const existing = document.getElementById('audioExistingCover');
          const placeholder = document.getElementById('audioCoverPlaceholder');
          const base64Input = document.getElementById('audioCoverImageBase64');
          const fileNameInput = document.getElementById('audioCoverFileName');

          if (!fileInput || !preview) {
            return;
          }

          fileInput.addEventListener('change', function() {
            const file = fileInput.files && fileInput.files[0];
            if (!file) return;

            const objectUrl = URL.createObjectURL(file);
            preview.src = objectUrl;
            preview.classList.2?.remove('hidden') || preview.classList.remove('hidden');

            if (existing) {
              existing.classList.add('hidden');
            }
            if (placeholder) {
              placeholder.classList.add('hidden');
            }

            const reader = new FileReader();
            reader.onload = function(ev) {
              const dataUrl = String(ev.target && ev.target.result ? ev.target.result : '');
              const commaIndex = dataUrl.indexOf(',');
              if (commaIndex >= 0 && base64Input) {
                base64Input.value = dataUrl.substring(commaIndex + 1);
              }
              if (fileNameInput) {
                fileNameInput.value = file.name || 'cover-upload.jpg';
              }
            };
            reader.readAsDataURL(file);
          });
        });
      </script> 

    </div>

</@layout.backofficeLayout>
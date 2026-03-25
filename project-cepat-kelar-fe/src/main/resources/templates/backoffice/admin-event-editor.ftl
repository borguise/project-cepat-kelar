<#assign activePage = "agenda">
<#import "/layout/backoffice_layout.ftl" as layout>
<#assign currentStatus = "Diproses">
<#if eventItem?? && eventItem.status?? && eventItem.status?has_content>
  <#assign currentStatus = eventItem.status>
</#if>

<@layout.backofficeLayout title="Admin - Editor Agenda" activePage=activePage adminName=adminName>

      <div class="max-w-4xl w-full mx-auto px-4">
        <h2 class="text-4xl font-bold font-gelasio text-black italic"><#if eventItem??>Edit Agenda<#else>Tambah Agenda Baru</#if></h2>
      </div>

      <#if successMessage??>
        <div class="max-w-4xl w-full mx-auto px-4">
          <div class="bg-green-100 border border-green-400 text-green-700 px-6 py-4 rounded-xl" role="alert">
            <span class="block sm:inline">${successMessage}</span>
          </div>
        </div>
      </#if>
      <#if errorMessage??>
        <div class="max-w-4xl w-full mx-auto px-4">
          <div class="bg-red-100 border border-red-400 text-red-700 px-6 py-4 rounded-xl" role="alert">
            <span class="block sm:inline">${errorMessage}</span>
          </div>
        </div>
      </#if>

      <form action="/admin/events/save" method="POST" enctype="multipart/form-data" 
            class="w-full max-w-4xl mx-auto bg-white rounded-3xl shadow-xl p-12 flex flex-col gap-8 mb-20 border border-stone-100">

        <input type="hidden" name="id" value="${(eventItem.id)!''}">
        
        <div class="flex flex-col gap-3 text-center">
          <label class="font-gelasio text-2xl text-black">Kegiatan</label>
          <input type="text" name="name" value="${(eventItem.name)!''}" placeholder="Tulis Judul disini" required
                 class="w-full py-4 border border-stone-200 rounded-xl px-8 font-lato text-xl text-indigo-800 text-center focus:ring-4 focus:ring-indigo-50 transition-all placeholder:text-stone-300">
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
          <div class="flex flex-col gap-3 text-center">
            <label class="font-gelasio text-2xl text-black">Tanggal & Jam Acara</label>
            <div class="flex gap-3 w-full">
              <input type="date" name="eventDateDate" value="<#if eventItem?? && eventItem.eventDate??>${eventItem.eventDate?string("yyyy-MM-dd")}</#if>" required
                     class="flex-1 py-4 px-4 border border-stone-200 rounded-xl font-lato text-base text-indigo-800 focus:ring-4 focus:ring-indigo-50 transition-all placeholder:text-stone-300 h-14" style="font-size: 16px;">
              <input type="time" name="eventDateTime" value="<#if eventItem?? && eventItem.eventDate??>${eventItem.eventDate?string("HH:mm")}</#if>" required
                     class="flex-1 py-4 px-4 border border-stone-200 rounded-xl font-lato text-base text-indigo-800 focus:ring-4 focus:ring-indigo-50 transition-all placeholder:text-stone-300 h-14" style="font-size: 16px;">
            </div>
            <input type="hidden" id="eventDateCombined" name="eventDate">
          </div>
          <div class="flex flex-col gap-3 text-center">
            <label class="font-gelasio text-2xl text-black">Status</label>
            <select name="status" class="w-full py-4 px-8 border border-stone-200 rounded-xl font-lato text-base text-indigo-800 text-center focus:ring-4 focus:ring-indigo-50 transition-all bg-white h-14 appearance-none cursor-pointer" style="font-size: 16px;">
              <option value="Diproses" <#if currentStatus == 'Diproses'>selected</#if>>Diproses</option>
              <option value="Disetujui" <#if currentStatus == 'Disetujui'>selected</#if>>Disetujui</option>
            </select>
          </div>
        </div>

        <div class="flex flex-col gap-3 text-center">
          <label class="font-gelasio text-2xl text-black">Tempat</label>
          <input type="text" name="location" value="${(eventItem.location)!''}" placeholder="Lokasi Acara" required
                 class="w-full py-4 border border-stone-200 rounded-xl px-8 font-lato text-xl text-indigo-800 text-center focus:ring-4 focus:ring-indigo-50 transition-all placeholder:text-stone-300">
        </div>

        <div class="flex flex-col gap-3 text-center">
          <label class="font-gelasio text-2xl text-black">Poster kegiatan</label>
          <label class="w-full py-10 border-2 border-dashed border-stone-200 rounded-2xl flex items-center justify-center cursor-pointer hover:bg-slate-50 transition relative overflow-hidden min-h-44">
            <#if eventItem?? && eventItem.posterImage?? && eventItem.posterImage?has_content>
              <img src="/admin/events/image/${eventItem.id?c}" class="absolute inset-0 w-full h-full object-cover" onerror="this.classList.add('hidden'); document.getElementById('eventPosterPlaceholder').classList.remove('hidden');">
              <span id="eventPosterPlaceholder" class="hidden text-indigo-800 text-sm font-lato z-10">Klik untuk upload gambar</span>
            <#else>
              <span id="eventPosterPlaceholder" class="text-indigo-800 text-sm font-lato z-10">Klik untuk upload gambar</span>
            </#if>
            <input type="file" name="poster" class="hidden">
          </label>
        </div>

        <div class="flex flex-col gap-3 text-center">
          <label class="font-gelasio text-2xl text-black">Deskripsi Kegiatan</label>
          <textarea id="autoExpand" name="description" placeholder="Keterangan" required
                    oninput="this.style.height = ''; this.style.height = this.scrollHeight + 'px'"
                    class="w-full min-h-[160px] py-12 border border-stone-200 rounded-2xl px-10 font-lato text-xl text-indigo-800 text-center focus:ring-4 focus:ring-indigo-50 transition-all resize-none overflow-hidden placeholder:text-stone-300">${(eventItem.description)!''}</textarea>
        </div>

        <div class="flex justify-center mt-6">
          <button type="submit" class="bg-[#bef264] text-indigo-900 px-24 py-4 rounded-xl shadow-lg font-bold text-lg hover:bg-lime-400 transition-all active:scale-95">
            <#if eventItem??>Simpan Perubahan<#else>Publikasikan</#if>
          </button>
        </div>

      </form> 

  <script>
    // Memastikan tinggi textarea pas saat dimuat pertama kali
    const tx = document.getElementById('autoExpand');
    tx.setAttribute('style', 'height:' + (tx.scrollHeight) + 'px;overflow-y:hidden;');

    // Combine date and time inputs into eventDate field
    const form = document.querySelector('form');
    const eventDateDateInput = document.querySelector('input[name="eventDateDate"]');
    const eventDateTimeInput = document.querySelector('input[name="eventDateTime"]');
    const eventDateCombined = document.getElementById('eventDateCombined');

    form.addEventListener('submit', function(e) {
      const date = eventDateDateInput.value;
      const time = eventDateTimeInput.value;
      if (date && time) {
        eventDateCombined.value = date + 'T' + time;
      }
    });
  </script>

</@layout.backofficeLayout>
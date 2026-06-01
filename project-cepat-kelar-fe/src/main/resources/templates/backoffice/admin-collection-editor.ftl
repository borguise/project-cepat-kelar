<#-- admin/editor-koleksi.ftl -->
<#assign activePage = "koleksi">
<#import "/layout/backoffice_layout.ftl" as layout>
<#assign currentStatus = "PUBLISHED">
<#if buku?? && buku.status?? && buku.status?has_content>
    <#assign currentStatus = buku.status>
</#if>

<@layout.backofficeLayout title="Admin - Editor Koleksi" activePage=activePage adminName=adminName>

    <div class="w-full max-w-6xl mx-auto px-4">
                <h2 class="text-3xl font-bold font-gelasio text-slate-800 italic mb-2"><#if buku??>Edit Buku Koleksi<#else>Tambah Buku Baru</#if></h2>
        <p class="text-slate-500 mb-8">Lengkapi data koleksi buku berikut.</p>
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

    <form id="collection-form" action="/admin/collections/save" method="POST" class="w-full max-w-6xl mx-auto bg-white rounded-3xl shadow-lg border border-slate-100 p-8 mb-10 flex flex-col gap-8">
        <input type="hidden" name="id" value="${(buku.id)!''}">
        <input type="hidden" name="coverImageBase64" id="coverImageBase64" value="">
        <input type="hidden" name="coverFileName" id="coverFileName" value="">

        <div class="flex flex-col lg:flex-row gap-10">
            <div class="flex-1 space-y-6">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-5">
                    <div>
                        <label class="block mb-2 font-gelasio font-bold text-slate-800">Subjek / Kategori</label>
                        <input type="text" name="subject" value="${(buku.subject)!''}" placeholder="Fiksi, Sejarah, dsb." class="w-full bg-white border border-slate-200 rounded-xl px-4 py-3 outline-none focus:ring-2 focus:ring-indigo-100">
                    </div>
                    <div>
                        <label class="block mb-2 font-gelasio font-bold text-slate-800">Judul Buku</label>
                        <input type="text" name="title" value="${(buku.title)!''}" placeholder="Masukkan judul lengkap" class="w-full bg-white border border-slate-200 rounded-xl px-4 py-3 outline-none focus:ring-2 focus:ring-indigo-100" required>
                    </div>
                    <div class="md:col-span-2">
                        <label class="block mb-2 font-gelasio font-bold text-slate-800">Tajuk Pengarang</label>
                        <input type="text" name="author" value="${(buku.author)!''}" placeholder="Nama belakang, Nama depan" class="w-full bg-white border border-slate-200 rounded-xl px-4 py-3 outline-none focus:ring-2 focus:ring-indigo-100">
                    </div>
                </div>
            </div>

            <div class="lg:w-64 flex flex-col gap-3">
                <label class="block font-gelasio font-bold text-slate-800 text-center">Sampul Buku</label>
                <label class="w-full aspect-[3/4] bg-slate-50 rounded-2xl border-2 border-dashed border-slate-300 flex flex-col items-center justify-center gap-3 group hover:border-indigo-400 transition cursor-pointer relative overflow-hidden">
                    <img id="coverPreview" src="" class="absolute inset-0 w-full h-full object-cover hidden" alt="Preview cover">
                    <#if buku?? && buku.coverImage?? && buku.coverImage?has_content>
                        <img id="existingCover" src="/admin/collections/image/${buku.id?c}" class="absolute inset-0 w-full h-full object-cover" onerror="this.classList.add('hidden')">
                        <span id="coverPlaceholder" class="hidden text-4xl text-slate-300">Upload</span>
                    <#else>
                        <span id="coverPlaceholder" class="text-4xl text-slate-300">Upload</span>
                    </#if>
                    <input id="coverFileInput" type="file" name="coverFile" class="absolute inset-0 opacity-0 cursor-pointer z-10" accept="image/*">
                    <span class="text-indigo-800 text-sm font-bold px-4 bg-white/90 py-1 rounded-full z-20">Unggah Gambar</span>
                </label>
            </div>
        </div>

        <div class="space-y-4">
            <h3 class="text-2xl font-bold font-gelasio text-indigo-900 border-b border-slate-100 pb-2">Data Penerbit</h3>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-5">
                <div>
                    <label class="block mb-2 font-gelasio font-bold text-slate-800">Penerbit</label>
                    <input type="text" name="publisher" value="${(buku.publisher)!''}" class="w-full bg-white border border-slate-200 rounded-xl px-4 py-3 outline-none focus:ring-2 focus:ring-indigo-100">
                </div>
                <div>
                    <label class="block mb-2 font-gelasio font-bold text-slate-800">Kota Terbit</label>
                    <input type="text" name="publishCity" value="${(buku.publishCity)!''}" class="w-full bg-white border border-slate-200 rounded-xl px-4 py-3 outline-none focus:ring-2 focus:ring-indigo-100">
                </div>
                <div>
                    <label class="block mb-2 font-gelasio font-bold text-slate-800">Tahun Terbit</label>
                    <input type="text" name="publishYear" value="${(buku.publishYear)!''}" placeholder="YYYY" class="w-full bg-white border border-slate-200 rounded-xl px-4 py-3 outline-none focus:ring-2 focus:ring-indigo-100">
                </div>
            </div>
        </div>

        <div class="space-y-4">
            <h3 class="text-2xl font-bold font-gelasio text-indigo-900 border-b border-slate-100 pb-2">Data Fisik & Stok</h3>
            <div>
                <label class="block mb-2 font-gelasio font-bold text-slate-800">Deskripsi Fisik</label>
                <textarea name="physicalDescription" rows="3" placeholder="Contoh: xii, 350 hlm; ilus; 20 cm." class="w-full bg-white border border-slate-200 rounded-xl px-4 py-3 outline-none focus:ring-2 focus:ring-indigo-100 resize-none">${(buku.physicalDescription)!''}</textarea>
            </div>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-5">
                <div>
                    <label class="block mb-2 font-gelasio font-bold text-slate-800">Nomor ISBN</label>
                    <input type="text" name="isbn" value="${(buku.isbn)!''}" placeholder="978-..." class="w-full bg-white border border-slate-200 rounded-xl px-4 py-3 outline-none focus:ring-2 focus:ring-indigo-100">
                </div>
                <div>
                    <label class="block mb-2 font-gelasio font-bold text-slate-800">Jumlah Stok</label>
                    <input type="number" name="stock" value="${(buku.stock)!'0'}" class="w-full bg-white border border-slate-200 rounded-xl px-4 py-3 outline-none focus:ring-2 focus:ring-indigo-100">
                </div>
            </div>
        </div>

        <div class="space-y-4">
            <h3 class="text-2xl font-bold font-gelasio text-indigo-900 border-b border-slate-100 pb-2">Klasifikasi</h3>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-5">
                <div>
                    <label class="block mb-2 font-gelasio font-bold text-slate-800">Nomor Panggil</label>
                    <input type="text" name="callNumber" value="${(buku.callNumber)!''}" placeholder="Contoh: 899.221 MAG" class="w-full bg-white border border-slate-200 rounded-xl px-4 py-3 outline-none focus:ring-2 focus:ring-indigo-100 h-14 text-base" style="font-size: 16px;">
                </div>
                <div>
                    <label class="block mb-2 font-gelasio font-bold text-slate-800">Status</label>
                    <select name="status" class="w-full bg-white border border-slate-200 rounded-xl px-4 py-3 outline-none focus:ring-2 focus:ring-indigo-100 h-14 text-base appearance-none cursor-pointer" style="font-size: 16px;">
                        <option value="PUBLISHED" <#if currentStatus == 'PUBLISHED'>selected</#if>>Dipublikasikan</option>
                        <option value="HIDDEN" <#if currentStatus == 'HIDDEN'>selected</#if>>Disembunyikan</option>
                    </select>
                </div>
            </div>
        </div>

        <div class="flex justify-end pt-4">
            <button type="submit" class="px-10 h-12 bg-[#bef264] text-indigo-900 rounded-xl shadow-md font-bold hover:bg-lime-400 transition-all active:scale-95 whitespace-nowrap">
                Simpan Buku
            </button>
        </div>
    </form>

    <script>
        (function () {
            const input = document.getElementById('coverFileInput');
            const preview = document.getElementById('coverPreview');
            const existing = document.getElementById('existingCover');
            const placeholder = document.getElementById('coverPlaceholder');

            if (!input || !preview) return;

            input.addEventListener('change', function () {
                const file = input.files && input.files[0];
                if (!file) return;

                const objectUrl = URL.createObjectURL(file);
                preview.src = objectUrl;
                preview.classList.remove('hidden');

                if (existing) {
                    existing.classList.add('hidden');
                }
                if (placeholder) {
                    placeholder.classList.add('hidden');
                }

                const base64Input = document.getElementById('coverImageBase64');
                const fileNameInput = document.getElementById('coverFileName');
                const reader = new FileReader();
                reader.onload = function (ev) {
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
        })();
    </script>



</@layout.backofficeLayout>
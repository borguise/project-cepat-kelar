<#-- admin/editor-koleksi.ftl -->
<#assign activePage = "koleksi">
<#import "/layout/backoffice_layout.ftl" as layout>
<#assign currentStatus = "PUBLISHED">
<#if buku?? && buku.status?? && buku.status?has_content>
    <#assign currentStatus = buku.status>
</#if>

<@layout.backofficeLayout title="Admin - Editor Koleksi" activePage=activePage adminName=adminName>

    <div class="w-full max-w-6xl mx-auto px-4 mb-6">
        <h2 class="text-3xl font-bold font-gelasio text-slate-800 italic">
            <#if buku??>Edit Buku Koleksi<#else>Tambah Buku Baru</#if>
        </h2>
    </div>

    <#-- Notifikasi -->
    <#if successMessage??><div class="max-w-6xl w-full mx-auto px-4 mb-4"><div class="bg-green-50 border border-green-200 text-green-700 px-6 py-4 rounded-xl text-sm">${successMessage}</div></div></#if>
    <#if errorMessage??><div class="max-w-6xl w-full mx-auto px-4 mb-4"><div class="bg-red-50 border border-red-200 text-red-700 px-6 py-4 rounded-xl text-sm">${errorMessage}</div></div></#if>

    <form id="collection-form" action="/admin/collections/save" method="POST" class="w-full max-w-6xl mx-auto bg-white rounded-3xl shadow-sm border border-slate-100 p-8 mb-10 flex flex-col gap-8">
        <input type="hidden" name="id" value="${(buku.id)!''}">
        <input type="hidden" name="coverImageBase64" id="coverImageBase64" value="">
        <input type="hidden" name="coverFileName" id="coverFileName" value="">

        <#-- Bagian Atas: Grid Data Utama & Upload -->
        <div class="grid grid-cols-1 lg:grid-cols-12 gap-8">
            <div class="lg:col-span-8 flex flex-col gap-6">
                <div>
                    <h3 class="text-xl font-bold font-gelasio text-indigo-900 border-b border-slate-100 pb-2 mb-6">Data Utama</h3>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-5">
                        <div class="md:col-span-2">
                            <label class="block mb-1.5 font-gelasio font-bold text-slate-700 text-sm">Nomor Panggil</label>
                            <input type="text" name="callNumber" value="${(buku.callNumber)!''}" class="w-full bg-slate-50 border border-slate-200 rounded-xl px-4 py-2.5 outline-none focus:ring-2 focus:ring-indigo-100 text-sm">
                        </div>
                        <div class="md:col-span-2">
                            <label class="block mb-1.5 font-gelasio font-bold text-slate-700 text-sm">Subjek / Kategori</label>
                            <input type="text" name="subject" value="${(buku.subject)!''}" class="w-full bg-slate-50 border border-slate-200 rounded-xl px-4 py-2.5 outline-none focus:ring-2 focus:ring-indigo-100 text-sm">
                        </div>
                        <div class="md:col-span-2">
                            <label class="block mb-1.5 font-gelasio font-bold text-slate-700 text-sm">Judul Buku</label>
                            <input type="text" name="title" value="${(buku.title)!''}" class="w-full bg-slate-50 border border-slate-200 rounded-xl px-4 py-2.5 outline-none focus:ring-2 focus:ring-indigo-100 text-sm" required>
                        </div>
                        <div class="md:col-span-2">
                            <label class="block mb-1.5 font-gelasio font-bold text-slate-700 text-sm">Tajuk Pengarang</label>
                            <input type="text" name="author" value="${(buku.author)!''}" class="w-full bg-slate-50 border border-slate-200 rounded-xl px-4 py-2.5 outline-none focus:ring-2 focus:ring-indigo-100 text-sm">
                        </div>
                    </div>
                </div>
            </div>

            <div class="lg:col-span-4 flex flex-col">
                <label class="block mb-2 font-gelasio font-bold text-slate-700 text-center text-sm">Sampul Buku</label>
                <label class="flex-1 w-full bg-slate-50 rounded-2xl border-2 border-dashed border-slate-300 flex flex-col items-center justify-center gap-2 group hover:border-indigo-400 transition cursor-pointer relative overflow-hidden min-h-[300px]">
                    <img id="coverPreview" src="" class="absolute inset-0 w-full h-full object-cover hidden">
                    <#if buku?? && buku.coverImage?? && buku.coverImage?has_content>
                        <img id="existingCover" src="/admin/collections/image/${buku.id?c}" class="absolute inset-0 w-full h-full object-cover">
                    </#if>
                    <span id="coverPlaceholder" class="text-sm text-slate-400">Unggah Gambar</span>
                    <input id="coverFileInput" type="file" name="coverFile" class="absolute inset-0 opacity-0 cursor-pointer z-10" accept="image/*">
                    <span class="text-indigo-800 text-xs font-bold px-4 bg-white/90 py-1 rounded-full z-20 shadow-sm border border-slate-100">Unggah</span>
                </label>
            </div>
        </div>

        <#-- Bagian Penerbit -->
        <div>
            <h3 class="text-xl font-bold font-gelasio text-indigo-900 border-b border-slate-100 pb-2 mb-6">Data Penerbit</h3>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-5">
                <div>
                    <label class="block mb-1.5 font-gelasio font-bold text-slate-700 text-sm">Penerbit</label>
                    <input type="text" name="publisher" value="${(buku.publisher)!''}" class="w-full bg-slate-50 border border-slate-200 rounded-xl px-4 py-2.5 outline-none focus:ring-2 focus:ring-indigo-100 text-sm">
                </div>
                <div>
                    <label class="block mb-1.5 font-gelasio font-bold text-slate-700 text-sm">Kota Terbit</label>
                    <input type="text" name="publishCity" value="${(buku.publishCity)!''}" class="w-full bg-slate-50 border border-slate-200 rounded-xl px-4 py-2.5 outline-none focus:ring-2 focus:ring-indigo-100 text-sm">
                </div>
                <div>
                    <label class="block mb-1.5 font-gelasio font-bold text-slate-700 text-sm">Tahun Terbit</label>
                    <input type="text" name="publishYear" value="${(buku.publishYear)!''}" class="w-full bg-slate-50 border border-slate-200 rounded-xl px-4 py-2.5 outline-none focus:ring-2 focus:ring-indigo-100 text-sm">
                </div>
            </div>
        </div>

        <#-- Bagian Deskripsi, Stok, ISBN & Status (Sesuai permintaan) -->
        <div class="flex flex-col gap-6">
             <h3 class="text-xl font-bold font-gelasio text-indigo-900 border-b border-slate-100 pb-2 mb-0">Detail Fisik & Klasifikasi</h3>
             
             <#-- Deskripsi Fisik (Penuh Lebar) -->
             <div>
                <label class="block mb-1.5 font-gelasio font-bold text-slate-700 text-sm">Deskripsi Fisik</label>
                <textarea name="physicalDescription" rows="2" class="w-full bg-slate-50 border border-slate-200 rounded-xl px-4 py-3 outline-none focus:ring-2 focus:ring-indigo-100 resize-none text-sm">${(buku.physicalDescription)!''}</textarea>
             </div>

             <#-- ISBN & Stok (Penuh lebar, di tengah) -->
             <div class="grid grid-cols-1 md:grid-cols-2 gap-5">
                <div>
                    <label class="block mb-1.5 font-gelasio font-bold text-slate-700 text-sm">Nomor ISBN</label>
                    <input type="text" name="isbn" value="${(buku.isbn)!''}" class="w-full bg-slate-50 border border-slate-200 rounded-xl px-4 py-2.5 outline-none focus:ring-2 focus:ring-indigo-100 text-sm">
                </div>
                <div>
                    <label class="block mb-1.5 font-gelasio font-bold text-slate-700 text-sm">Jumlah Stok</label>
                    <input type="number" name="stock" value="${(buku.stock)!'0'}" class="w-full bg-slate-50 border border-slate-200 rounded-xl px-4 py-2.5 outline-none focus:ring-2 focus:ring-indigo-100 text-sm">
                </div>
             </div>

             <#-- Status (Baris terakhir, lebar penuh) -->
             <div>
                <label class="block mb-1.5 font-gelasio font-bold text-slate-700 text-sm">Status Publikasi</label>
                <select name="status" class="w-full bg-slate-50 border border-slate-200 rounded-xl px-4 py-2.5 outline-none focus:ring-1 focus:ring-indigo-100 cursor-pointer text-sm">
                    <option value="PUBLISHED" <#if currentStatus == 'PUBLISHED'>selected</#if>>Dipublikasikan</option>
                    <option value="HIDDEN" <#if currentStatus == 'HIDDEN'>selected</#if>>Disembunyikan</option>
                </select>
             </div>
        </div>

        <#-- Tombol Simpan (Tengah bawah) -->
        <div class="flex justify-center pt-4">
            <button type="submit" class="w-full md:w-auto px-16 h-12 bg-[#bef264] text-indigo-900 rounded-xl shadow-md font-bold hover:bg-lime-400 transition-all active:scale-95 text-sm">
                Simpan Buku
            </button>
        </div>
    </form>

    <script>
        const input = document.getElementById('coverFileInput');
        const preview = document.getElementById('coverPreview');
        const existing = document.getElementById('existingCover');
        const placeholder = document.getElementById('coverPlaceholder');

        if (input) {
            input.addEventListener('change', function () {
                const file = input.files && input.files[0];
                if (!file) return;
                const objectUrl = URL.createObjectURL(file);
                preview.src = objectUrl;
                preview.classList.remove('hidden');
                if (existing) existing.classList.add('hidden');
                if (placeholder) placeholder.classList.add('hidden');
            });
        }
    </script>
</@layout.backofficeLayout>
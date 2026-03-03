<#-- admin/editor-koleksi.ftl -->
<#assign activePage = "koleksi">
<#import "/layout/backoffice_layout.ftl" as layout>

<@layout.backofficeLayout title="Admin - Editor Koleksi" activePage=activePage adminName=adminName>

    <div class="w-full max-w-6xl mx-auto px-4">
        <h2 class="text-3xl font-bold font-gelasio text-slate-800 italic mb-2">Tambah Buku Baru</h2>
        <p class="text-slate-500 mb-8">Lengkapi data koleksi buku berikut.</p>
    </div>

    <form action="/admin/collections/save" method="POST" enctype="multipart/form-data" class="w-full max-w-6xl mx-auto bg-white rounded-3xl shadow-lg border border-slate-100 p-8 mb-10 flex flex-col gap-8">
        <input type="hidden" name="id" value="${(buku.id)!''}">

        <div class="flex flex-col lg:flex-row gap-10">
            <div class="flex-1 space-y-6">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-5">
                    <div>
                        <label class="block mb-2 font-gelasio font-bold text-slate-800">Subjek / Kategori</label>
                        <input type="text" name="subjek" value="${(buku.subjek)!''}" placeholder="Fiksi, Sejarah, dsb." class="w-full bg-white border border-slate-200 rounded-xl px-4 py-3 outline-none focus:ring-2 focus:ring-indigo-100">
                    </div>
                    <div>
                        <label class="block mb-2 font-gelasio font-bold text-slate-800">Judul Buku</label>
                        <input type="text" name="judul" value="${(buku.judul)!''}" placeholder="Masukkan judul lengkap" class="w-full bg-white border border-slate-200 rounded-xl px-4 py-3 outline-none focus:ring-2 focus:ring-indigo-100">
                    </div>
                    <div class="md:col-span-2">
                        <label class="block mb-2 font-gelasio font-bold text-slate-800">Tajuk Pengarang</label>
                        <input type="text" name="pengarang" value="${(buku.pengarang)!''}" placeholder="Nama belakang, Nama depan" class="w-full bg-white border border-slate-200 rounded-xl px-4 py-3 outline-none focus:ring-2 focus:ring-indigo-100">
                    </div>
                </div>
            </div>

            <div class="lg:w-64 flex flex-col gap-3">
                <label class="block font-gelasio font-bold text-slate-800 text-center">Sampul Buku</label>
                <label class="w-full aspect-[3/4] bg-slate-50 rounded-2xl border-2 border-dashed border-slate-300 flex flex-col items-center justify-center gap-3 group hover:border-indigo-400 transition cursor-pointer relative overflow-hidden">
                    <#if (buku.sampul)?? && buku.sampul?has_content>
                        <img src="${buku.sampul}" class="absolute inset-0 w-full h-full object-cover" onerror="this.classList.add('hidden')">
                    <#else>
                        <span class="text-4xl text-slate-300">📷</span>
                    </#if>
                    <input type="file" name="fileSampul" class="absolute inset-0 opacity-0 cursor-pointer z-10">
                    <span class="text-indigo-800 text-sm font-bold px-4 bg-white/90 py-1 rounded-full z-20">Unggah Gambar</span>
                </label>
            </div>
        </div>

        <div class="space-y-4">
            <h3 class="text-2xl font-bold font-gelasio text-indigo-900 border-b border-slate-100 pb-2">Data Penerbit</h3>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-5">
                <div>
                    <label class="block mb-2 font-gelasio font-bold text-slate-800">Penerbit</label>
                    <input type="text" name="penerbit" value="${(buku.penerbit)!''}" class="w-full bg-white border border-slate-200 rounded-xl px-4 py-3 outline-none focus:ring-2 focus:ring-indigo-100">
                </div>
                <div>
                    <label class="block mb-2 font-gelasio font-bold text-slate-800">Kota Terbit</label>
                    <input type="text" name="kota" value="${(buku.kota)!''}" class="w-full bg-white border border-slate-200 rounded-xl px-4 py-3 outline-none focus:ring-2 focus:ring-indigo-100">
                </div>
                <div>
                    <label class="block mb-2 font-gelasio font-bold text-slate-800">Tahun Terbit</label>
                    <input type="text" name="tahun" value="${(buku.tahun)!''}" placeholder="YYYY" class="w-full bg-white border border-slate-200 rounded-xl px-4 py-3 outline-none focus:ring-2 focus:ring-indigo-100">
                </div>
            </div>
        </div>

        <div class="space-y-4">
            <h3 class="text-2xl font-bold font-gelasio text-indigo-900 border-b border-slate-100 pb-2">Data Fisik & Stok</h3>
            <div>
                <label class="block mb-2 font-gelasio font-bold text-slate-800">Deskripsi Fisik</label>
                <textarea name="deskripsiFisik" rows="3" placeholder="Contoh: xii, 350 hlm; ilus; 20 cm." class="w-full bg-white border border-slate-200 rounded-xl px-4 py-3 outline-none focus:ring-2 focus:ring-indigo-100 resize-none">${(buku.deskripsiFisik)!''}</textarea>
            </div>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-5">
                <div>
                    <label class="block mb-2 font-gelasio font-bold text-slate-800">Nomor ISBN</label>
                    <input type="text" name="isbn" value="${(buku.isbn)!''}" placeholder="978-..." class="w-full bg-white border border-slate-200 rounded-xl px-4 py-3 outline-none focus:ring-2 focus:ring-indigo-100">
                </div>
                <div>
                    <label class="block mb-2 font-gelasio font-bold text-slate-800">Jumlah Stok</label>
                    <input type="number" name="stok" value="${(buku.stok)!'0'}" class="w-full bg-white border border-slate-200 rounded-xl px-4 py-3 outline-none focus:ring-2 focus:ring-indigo-100">
                </div>
            </div>
        </div>

        <div class="flex justify-end pt-4">
            <button type="submit" class="px-10 h-12 bg-[#bef264] text-indigo-900 rounded-xl shadow-md font-bold hover:bg-lime-400 transition-all active:scale-95 whitespace-nowrap">
                Simpan Buku
            </button>
        </div>
    </form>

</@layout.backofficeLayout>
<#assign activePage = "voting">
<#import "/layout/backoffice_layout.ftl" as layout>
<@layout.backofficeLayout title="Admin - Editor Voting" activePage=activePage adminName=adminName>

    <div class="w-full max-w-6xl mx-auto relative">      
      
      <div class="max-w-6xl w-full mx-auto px-4">
        <h2 class="text-3xl font-bold font-gelasio text-slate-800 italic">Manajemen Pemilihan</h2>
      </div>

      <div class="w-full max-w-6xl mx-auto bg-white rounded-3xl shadow-lg border border-slate-100 p-8 mb-8 flex flex-col gap-8">
        
        <!-- ======================================================= -->
        <!-- FORM 1: INFO UTAMA (Wajib klik Simpan Draf sebelum tambah kandidat) -->
        <!-- ======================================================= -->
        <form action="/admin/voting/save" method="POST" id="formVotingUtama">
            <input type="hidden" name="id" value="${(voting.id)!0}">
            <input type="hidden" name="status" value="${(voting.status)!'Draft'}">
            
            <div class="space-y-5">
                <div class="flex justify-between items-center">
                    <h3 class="text-xl font-bold font-gelasio text-indigo-800 italic border-l-4 border-indigo-800 pl-3">Kegiatan Pemilihan</h3>
                    <button type="submit" class="bg-indigo-600 hover:bg-indigo-700 text-white font-bold px-6 py-2 rounded-xl shadow-md transition-all text-sm">
                        Simpan Draf
                    </button>
                </div>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div class="md:col-span-2">
                        <input type="text" name="name" value="${(voting.name)!''}" placeholder="Nama Kegiatan Pemilihan" class="input-premium" required>
                    </div>
                    <div>
                        <label class="label-elegant">Tanggal Mulai</label>
                        <input type="date" name="startDate" value="${(voting.startDate)!''}" class="input-premium" required>
                    </div>
                    <div>
                        <label class="label-elegant">Tanggal Selesai</label>
                        <input type="date" name="endDate" value="${(voting.endDate)!''}" class="input-premium" required>
                    </div>
                </div>
            </div>
        </form>

        <hr class="border-slate-50">

        <!-- ======================================================= -->
        <!-- FORM 2: TAMBAH KANDIDAT -->
        <!-- ======================================================= -->
        <#if voting.id?? && voting.id gt 0>
            <form action="/admin/voting/entry/save" method="POST" class="flex flex-col lg:flex-row gap-10">
                <input type="hidden" name="votingId" value="${voting.id}">
                
                <div class="lg:w-56 flex flex-col items-center gap-3">
                    <label class="label-elegant">Unggah foto Kandidat</label>
                    <div class="w-52 h-52 bg-slate-50 border-2 border-dashed border-slate-200 rounded-2xl flex items-center justify-center cursor-pointer hover:bg-white transition-all group shadow-sm relative overflow-hidden">
                        <img id="kandidatPreviewImage" src="" class="w-full h-full object-cover hidden">
                        <div id="kandidatPlaceholderImage" class="text-center p-4">
                            <span class="block text-2xl mb-1 group-hover:scale-110 transition">Image</span>
                            <span class="text-indigo-800 font-bold font-lato text-xs">Unggah Gambar</span>
                        </div>
                        <input type="file" id="kandidatFileInput" class="absolute inset-0 opacity-0 cursor-pointer" accept="image/*">
                        <input type="hidden" name="entryPhotoBase64" id="kandidatFotoBase64">
                    </div>
                </div>

                <div class="flex-1 space-y-5">
                    <div>
                        <label class="label-elegant">Nama Kandidat</label>
                        <input type="text" name="name" placeholder="Contoh: Andi" class="input-premium" required>
                    </div>
                    <div>
                        <label class="label-elegant">Keterangan singkat</label>
                        <textarea name="summary" placeholder="Visi Misi..." class="input-premium w-full h-28 resize-none py-3" required></textarea>
                        <div class="flex justify-end mt-5 mb-2">
                            <button type="submit" class="bg-[#bef264] hover:bg-lime-400 text-indigo-900 font-bold px-6 py-2 rounded-xl shadow-md transition-all active:scale-95 text-sm font-lato">
                                + Tambah Entri
                            </button>
                        </div>
                    </div>
                </div>
            </form>
        <#else>
            <div class="p-4 bg-yellow-50 text-yellow-800 rounded-xl border border-yellow-200">
                Silakan isi Nama dan Tanggal di atas lalu klik **Simpan Draf** untuk mengaktifkan fitur tambah kandidat.
            </div>
        </#if>

        <hr class="border-slate-50">

        <!-- ======================================================= -->
        <!-- TABEL KANDIDAT -->
        <!-- ======================================================= -->
        <div class="space-y-5">
            <h3 class="text-xl font-bold font-gelasio text-indigo-800 italic border-l-4 border-indigo-800 pl-3">Daftar Kandidat</h3>
            <div class="border border-slate-100 rounded-2xl overflow-hidden shadow-sm">
                <table class="table-custom font-lato w-full text-left">
                    <thead class="bg-slate-50 text-black font-bold">
                        <tr>
                            <th class="p-4">Nama Kandidat</th>
                            <th class="p-4">Deskripsi</th>
                            <th class="w-32 p-4 text-center">Aksi</th>
                        </tr>
                    </thead>
                    <tbody class="text-slate-700">
                        <#if entries?has_content>
                            <#list entries as entry>
                            <tr class="border-t border-slate-100">
                                <td class="font-bold text-black p-4">${entry.name}</td>
                                <td class="text-sm p-4">${entry.summary}</td>
                                <td class="p-4 text-center">
                                    <form action="/admin/voting/entry/delete/${entry.id}" method="POST" onsubmit="return confirm('Hapus kandidat ini?');">
                                        <input type="hidden" name="votingId" value="${voting.id}">
                                        <button type="submit" class="text-red-500 font-bold text-sm">Delete</button>
                                    </form>
                                </td>
                            </tr>
                            </#list>
                        <#else>
                            <tr>
                                <td colspan="3" class="py-6 text-slate-400 italic text-center">Belum ada kandidat.</td>
                            </tr>
                        </#if>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- ======================================================= -->
        <!-- TOMBOL PUBLIKASI -->
        <!-- ======================================================= -->
        <div class="flex justify-center pt-6 border-t border-slate-50">
            <form action="/admin/voting/save" method="POST">
                <input type="hidden" name="id" value="${(voting.id)!0}">
                <input type="hidden" name="name" value="${(voting.name)!''}">
                <input type="hidden" name="startDate" value="${(voting.startDate)!''}">
                <input type="hidden" name="endDate" value="${(voting.endDate)!''}">
                <input type="hidden" name="status" value="Aktif">
                <button type="submit" class="bg-[#bef264] hover:bg-lime-400 text-indigo-900 font-bold px-24 py-4 rounded-2xl shadow-lg transition-all active:scale-95 text-xl font-lato">
                    Publikasikan Pemilihan
                </button>
            </form>
        </div>
      </div> 

      <script>
        document.addEventListener('DOMContentLoaded', function() {
            const fileInput = document.getElementById('kandidatFileInput');
            const preview = document.getElementById('kandidatPreviewImage');
            const placeholder = document.getElementById('kandidatPlaceholderImage');
            const base64Input = document.getElementById('kandidatFotoBase64');
            
            if (fileInput) {
                fileInput.addEventListener('change', function() {
                    const file = this.files[0];
                    if (!file) return;
                    preview.src = URL.createObjectURL(file);
                    preview.classList.remove('hidden');
                    placeholder.classList.add('hidden');
                    const reader = new FileReader();
                    reader.onload = function(e) { base64Input.value = e.target.result; };
                    reader.readAsDataURL(file);
                });
            }
        });
      </script>
    </div>
</@layout.backofficeLayout>
<#-- admin/voting-editor.ftl -->
<#assign activePage = "voting">
<#import "/layout/backoffice_layout.ftl" as layout>
<@layout.backofficeLayout title="Admin - Editor Voting" activePage=activePage adminName=adminName>

    <div class="w-full max-w-6xl mx-auto relative">      
      
      <div class="max-w-6xl w-full mx-auto px-4">
        <h2 class="text-3xl font-bold font-gelasio text-slate-800 italic">Manajemen Pemilihan</h2>
      </div>

      <div class="w-full max-w-6xl mx-auto bg-white rounded-3xl shadow-lg border border-slate-100 p-8 mb-8 flex flex-col gap-8">
        
        <!-- ======================================================= -->
        <!-- FORM 1: INFO UTAMA & STATUS PUBLIKASI -->
        <!-- ======================================================= -->
        <form action="/admin/voting/save" method="POST" id="formVotingUtama">
            <input type="hidden" name="id" value="${(voting.id)!0}">
            
            <div class="space-y-5">
                <div class="flex justify-between items-center">
                    <div>
                        <h3 class="text-xl font-bold font-gelasio text-indigo-800 italic border-l-4 border-indigo-800 pl-3">Informasi Kegiatan</h3>
                        <p class="text-xs text-slate-400 mt-1 pl-4">Simpan bagian ini terlebih dahulu jika ada perubahan nama, tanggal, atau status.</p>
                    </div>
                    <button type="submit" class="bg-indigo-600 hover:bg-indigo-700 text-white font-bold px-6 py-2.5 rounded-xl shadow-md transition-all text-sm flex items-center gap-2">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                          <path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7" />
                        </svg>
                        Simpan Info Kegiatan
                    </button>
                </div>
                
                <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                    <div class="md:col-span-3">
                        <label class="label-elegant">Nama Kegiatan</label>
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
                    
                    <!-- FIELD STATUS PROPOSIONAL (SEJAJAR DENGAN TANGGAL) -->
                    <div>
                        <label class="label-elegant flex items-center gap-1.5">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-indigo-600" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                              <path stroke-linecap="round" stroke-linejoin="round" d="M3.055 11H5a2 2 0 012 2v1a2 2 0 002 2 2 2 0 012 2v2.945M8 3.935V5.5A2.5 2.5 0 0010.5 8h.5a2 2 0 012 2 2 2 0 104 0 2 2 0 012-2h1.064M15 20.488V18a2 2 0 012-2h3.064M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                            </svg>
                            Status Publikasi
                        </label>
                        <select name="status" class="input-premium font-semibold text-indigo-900 bg-white">
                            <option value="Draft" ${((voting.status!'Draft') == 'Draft')?string('selected', '')}>Draft (Disembunyikan)</option>
                            <option value="Aktif" ${((voting.status!'') == 'Aktif')?string('selected', '')}>Publikasi</option>
                            <option value="Selesai" ${((voting.status!'') == 'Selesai')?string('selected', '')}>Selesai (Arsip)</option>
                        </select>
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
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-10 w-10 mx-auto text-slate-400 mb-2 group-hover:scale-110 transition" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z" />
                            </svg>
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
                                + Tambah Entri Kandidat
                            </button>
                        </div>
                    </div>
                </div>
            </form>
        <#else>
            <div class="p-4 bg-yellow-50 text-yellow-800 rounded-xl border border-yellow-200 font-lato text-sm">
                Silakan isi Nama, Tanggal, dan Status di atas lalu klik tombol <strong>Simpan Info Kegiatan</strong> di pojok kanan atas untuk mengaktifkan fitur tambah kandidat.
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
        <!-- NAVIGASI KELUAR / KEMBALI -->
        <!-- ======================================================= -->
        <div class="flex flex-col items-center justify-center pt-8 border-t border-slate-100 gap-2">
            <a href="/admin/voting" class="w-full max-w-md py-4 bg-slate-800 hover:bg-slate-900 text-white rounded-2xl font-bold font-lato text-base text-center shadow-md transition-all transform hover:-translate-y-0.5 active:scale-95 flex items-center justify-center gap-2">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2.5">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                </svg>
                Selesai & Kembali ke Daftar Pemilihan
            </a>
            <span class="text-xs text-slate-500 italic font-lato">Pastikan Anda sudah menekan tombol "Simpan Info Kegiatan" di atas jika ada perubahan data.</span>
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
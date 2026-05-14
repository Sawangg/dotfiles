-- Env variables for NVIDIA GPUs --
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("NVD_BACKEND", "direct")

-- VA-API hardware video acceleration --
hl.config({
  cursor = {
    no_hardware_cursors = true,
  },
})

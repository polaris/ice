(in-package #:ice/tests)

(in-suite :ice/tests)

(test test-downscale-pixel-color
  (is (equalp (ice::downscale-pixel-color (3d-vectors:vec 1 1 1) 1) (3d-vectors:vec 1 1 1)))
  (is (equalp (ice::downscale-pixel-color (3d-vectors:vec 1 1 1) 2) (3d-vectors:vec 0.5 0.5 0.5))))

(test test-gamma-correct
  (is (equalp (ice::gamma-correct (3d-vectors:vec 1 1 1)) (3d-vectors:vec 0.999 0.999 0.999)))
  (is (equalp (ice::gamma-correct (3d-vectors:vec 0.5 0.5 0.5)) (3d-vectors:vec 0.70710677 0.70710677 0.70710677)))
  (is (equalp (ice::gamma-correct (3d-vectors:vec 0 0 0)) (3d-vectors:vec 0 0 0))))

(test test-calculate-pixel-color
  (is (equalp (ice::calculate-pixel-color (3d-vectors:vec 1 1 1) 1) (3d-vectors:vec 255 255 255))))

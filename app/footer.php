<?php
// Get user role from session if logged in
$userType = $_SESSION['user_type'] ?? null;
$isLoggedIn = isset($_SESSION['user_id']);
?>

<footer class="site-footer">
  <div class="footer-inner">
    <div class="footer-brand">
      <span class="brand-name">Tripistry</span>
      <p>Your journey, curated.</p>
    </div>
    <div class="footer-links">
      
      <!-- Show Traveller links only for travellers or non-logged in users -->
      <?php if (!$isLoggedIn || $userType === 'traveller'): ?>
      <div class="footer-col">
        <h4>Travellers</h4>
        <a href="/NanlaPA5/app/traveller/browse.php">Browse packages</a>
        <a href="/NanlaPA5/app/traveller/packages.php">Compare packages</a>
        <a href="/NanlaPA5/app/register.php">Create account</a>
      </div>
      <?php endif; ?>

      <!-- Show Agency links only for agencies -->
      <?php if ($isLoggedIn && $userType === 'agency'): ?>
      <div class="footer-col">
        <h4>Agencies</h4>
        <a href="/NanlaPA5/app/travel-agency/packages.php">My Packages</a>
        <a href="/NanlaPA5/app/travel-agency/group-trips.php">Group Trips</a>
        <a href="/NanlaPA5/app/travel-agency/profile.php">Profile</a>
      </div>
      <?php endif; ?>

      <!-- Company links (shown to everyone) -->
      <div class="footer-col">
        <h4>Company</h4>
        <a href="#">About</a>
        <a href="#">Contact</a>
        <a href="#">Privacy policy</a>
      </div>

    </div>
  </div>
  <div class="footer-bottom">
    <p>© <?= date('Y') ?> Tripistry. All rights reserved.</p>
  </div>
</footer>

<script src="/NanlaPA5/app/js/main.js"></script>
<?php if (isset($pageScript)): ?>
<script src="<?= $pageScript ?>"></script> 
<?php endif; ?>
</body>
</html>


<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
$userType = $_SESSION['user_type'] ?? null;
$isLoggedIn = isset($_SESSION['user_id']);
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title><?= $pageTitle ?? 'Tripistry' ?></title>
  <link rel="stylesheet" href="/NanlaPA5/app/css/main.css" />
</head>
<body>

<nav class="navbar">
  <a href="/index.php" class="nav-brand">
    <span class="brand-name">Tripistry</span>
  </a>

  <?php if ($isLoggedIn && $userType === 'traveller'): ?>
    <ul class="nav-links">
      <li><a href="/NanlaPA5/app/traveller/browse.php">Browse</a></li>
      <li><a href="/NanlaPA5/app/traveller/packages.php">Packages</a></li>
      <li><a href="/traveller/my-bookings.php">My Bookings</a></li>
    </ul>
    <div class="nav-actions">
      <a href="/NanlaPA5/app/traveller/profile.php" class="nav-profile">
        <div class="avatar"><?= strtoupper(substr($_SESSION['user_name'] ?? 'T', 0, 1)) ?></div>
        <span><?= htmlspecialchars($_SESSION['user_name'] ?? 'Traveller') ?></span>
      </a>
      <a href="/NanlaPA5/app/api.php?action=logout" class="btn-logout">Sign out</a>
    </div>

  <?php elseif ($isLoggedIn && $userType === 'agency'): ?>
    <ul class="nav-links">
      <li><a href="/NanlaPA5/app/agency/packages.php">My Packages</a></li>
      <li><a href="/NanlaPA5/app/agency/group-trips.php">Group Trips</a></li>
    </ul>
    <div class="nav-actions">
      <a href="/NanlaPA5/app/agency/profile.php" class="nav-profile">
        <div class="avatar agency-avatar"><?= strtoupper(substr($_SESSION['user_name'] ?? 'A', 0, 1)) ?></div>
        <span><?= htmlspecialchars($_SESSION['user_name'] ?? 'Agency') ?></span>
      </a>
      <a href="/NanlaPA5/app/api.php?action=logout" class="btn-logout">Sign out</a>
    </div>

  <?php else: ?>
    <ul class="nav-links">
      <li><a href="/index.php">Home</a></li>
    </ul>
    <div class="nav-actions">
      <a href="/NanlaPA5/app/login.php" class="btn-outline">Sign in</a>
      <a href="/NanlaPA5/app/register.php" class="btn-primary">Get started</a>
    </div>
  <?php endif; ?>

  <button class="nav-toggle" onclick="toggleMobileNav()" aria-label="Toggle navigation">
    <span></span><span></span><span></span>
  </button>
</nav>
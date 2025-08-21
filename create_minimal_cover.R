# Minimalist Project Cover
# Clean, simple design with Bayesian curves

library(ggplot2)
library(grid)
library(gridExtra)

# Create minimalist cover
create_minimal_cover <- function() {
  
  # Define minimal color palette
  prior_color <- "#E8E8E8"  # Light gray
  posterior_color <- "#2E86AB"  # Deep blue
  accent_color <- "#FF6B6B"  # Soft red for trust indicator
  text_color <- "#2D3748"  # Dark gray
  
  # Generate Bayesian curves data
  theta <- seq(0, 1, length.out = 500)
  
  # Create multiple prior/posterior pairs for visual effect
  curves_data <- data.frame()
  
  # Add three different scenarios (representing different levels of trust)
  # Low trust scenario
  curves_data <- rbind(curves_data,
    data.frame(
      theta = theta,
      density = dbeta(theta, 3, 7),  # Prior - skeptical
      type = "Prior",
      scenario = 1
    ),
    data.frame(
      theta = theta,
      density = dbeta(theta, 8, 12),  # Posterior - still low trust
      type = "Posterior",
      scenario = 1
    )
  )
  
  # Medium trust scenario
  curves_data <- rbind(curves_data,
    data.frame(
      theta = theta,
      density = dbeta(theta, 5, 5),  # Prior - neutral
      type = "Prior",
      scenario = 2
    ),
    data.frame(
      theta = theta,
      density = dbeta(theta, 15, 10),  # Posterior - moderate trust
      type = "Posterior",
      scenario = 2
    )
  )
  
  # High trust scenario
  curves_data <- rbind(curves_data,
    data.frame(
      theta = theta,
      density = dbeta(theta, 7, 3),  # Prior - optimistic
      type = "Prior",
      scenario = 3
    ),
    data.frame(
      theta = theta,
      density = dbeta(theta, 22, 8),  # Posterior - high trust
      type = "Posterior",
      scenario = 3
    )
  )
  
  # Main visualization plot
  main_plot <- ggplot(curves_data, aes(x = theta, y = density, 
                                       color = type, 
                                       alpha = type,
                                       group = interaction(type, scenario))) +
    geom_line(size = 1.5) +
    scale_color_manual(values = c("Prior" = prior_color, 
                                  "Posterior" = posterior_color)) +
    scale_alpha_manual(values = c("Prior" = 0.4, 
                                  "Posterior" = 1)) +
    
    # Add subtle vertical lines for trust levels
    geom_vline(xintercept = 0.3, linetype = "dotted", color = accent_color, alpha = 0.3) +
    geom_vline(xintercept = 0.5, linetype = "dotted", color = accent_color, alpha = 0.3) +
    geom_vline(xintercept = 0.7, linetype = "dotted", color = accent_color, alpha = 0.3) +
    
    # Minimal labels
    annotate("text", x = 0.5, y = max(curves_data$density) * 0.95, 
             label = "Trust in AI Healthcare", 
             size = 14, color = text_color, fontface = "bold", hjust = 0.5) +
    
    annotate("text", x = 0.5, y = max(curves_data$density) * 0.88, 
             label = "Bayesian Analysis", 
             size = 10, color = text_color, hjust = 0.5) +
    
    # Subtle trust level indicators
    annotate("text", x = 0.3, y = -0.3, label = "Low", 
             size = 3, color = accent_color, alpha = 0.5) +
    annotate("text", x = 0.5, y = -0.3, label = "Medium", 
             size = 3, color = accent_color, alpha = 0.5) +
    annotate("text", x = 0.7, y = -0.3, label = "High", 
             size = 3, color = accent_color, alpha = 0.5) +
    
    # Clean theme
    theme_minimal() +
    theme(
      panel.grid = element_blank(),
      axis.title = element_blank(),
      axis.text = element_blank(),
      axis.ticks = element_blank(),
      legend.position = "none",
      plot.background = element_rect(fill = "white", color = NA),
      panel.background = element_rect(fill = "white", color = NA),
      plot.margin = margin(40, 40, 40, 40)
    ) +
    xlim(0, 1) +
    ylim(-0.5, max(curves_data$density) * 1.1)
  
  return(main_plot)
}

# Generate alternative ultra-minimal version
create_ultra_minimal <- function() {
  
  # Define colors
  prior_color <- "#D3D3D3"  # Light gray
  posterior_color <- "#1E40AF"  # Deep blue
  
  # Generate single clean curve pair
  theta <- seq(0, 1, length.out = 500)
  
  curves_data <- data.frame(
    theta = rep(theta, 2),
    density = c(dbeta(theta, 5, 5),  # Prior - uniform-ish
                dbeta(theta, 18, 12)),  # Posterior - shifted right
    type = factor(rep(c("Prior", "Posterior"), each = length(theta)),
                  levels = c("Prior", "Posterior"))
  )
  
  # Create plot
  minimal_plot <- ggplot(curves_data, aes(x = theta, y = density, 
                                          fill = type, 
                                          alpha = type)) +
    geom_area(position = "identity") +
    scale_fill_manual(values = c("Prior" = prior_color, 
                                 "Posterior" = posterior_color)) +
    scale_alpha_manual(values = c("Prior" = 0.3, 
                                  "Posterior" = 0.8)) +
    
    # Single title
    annotate("text", x = 0.5, y = max(curves_data$density) * 1.15, 
             label = "BAYESIAN TRUST ANALYSIS", 
             size = 12, color = "#1A202C", fontface = "bold", hjust = 0.5) +
    
    annotate("text", x = 0.5, y = max(curves_data$density) * 1.05, 
             label = "AI Healthcare Decision Making", 
             size = 8, color = "#4A5568", hjust = 0.5) +
    
    # Minimal legend
    annotate("text", x = 0.15, y = max(curves_data$density) * 0.9, 
             label = "Prior", 
             size = 6, color = prior_color, fontface = "bold") +
    annotate("text", x = 0.85, y = max(curves_data$density) * 0.9, 
             label = "Posterior", 
             size = 6, color = posterior_color, fontface = "bold") +
    
    # Ultra clean theme
    theme_void() +
    theme(
      plot.background = element_rect(fill = "white", color = NA),
      plot.margin = margin(30, 30, 30, 30)
    )
  
  return(minimal_plot)
}

# Generate both versions
print("Creating minimalist covers...")

# Version 1: Multiple curves
cover_v1 <- create_minimal_cover()
ggsave("project_cover_minimal.pdf", plot = cover_v1, 
       width = 11, height = 8.5, dpi = 300, device = "pdf")
ggsave("project_cover_minimal.png", plot = cover_v1, 
       width = 11, height = 8.5, dpi = 300, device = "png", bg = "white")

# Version 2: Ultra minimal
cover_v2 <- create_ultra_minimal()
ggsave("project_cover_ultra_minimal.pdf", plot = cover_v2, 
       width = 11, height = 8.5, dpi = 300, device = "pdf")
ggsave("project_cover_ultra_minimal.png", plot = cover_v2, 
       width = 11, height = 8.5, dpi = 300, device = "png", bg = "white")

print("✅ Created two minimalist versions:")
print("  1. project_cover_minimal.pdf/png - Multiple trust scenarios")
print("  2. project_cover_ultra_minimal.pdf/png - Single curve pair")
print("📁 Clean, professional covers ready for portfolio!")
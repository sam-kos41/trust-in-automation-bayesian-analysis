# Project Cover Infographic Generator
# Creates a beautiful PDF summary of the Bayesian Trust Analysis project

library(ggplot2)
library(grid)
library(gridExtra)
library(RColorBrewer)
library(scales)

# Create the cover infographic
create_project_cover <- function() {
  
  # Define color palette
  primary_color <- "#2E86AB"
  secondary_color <- "#A23B72"
  accent_color <- "#F18F01"
  text_color <- "#2D3748"
  light_gray <- "#F7FAFC"
  
  # Create main title plot
  title_plot <- ggplot() + 
    annotate("text", x = 0.5, y = 0.8, 
             label = "BAYESIAN ANALYSIS", 
             size = 24, fontface = "bold", 
             color = primary_color, hjust = 0.5) +
    annotate("text", x = 0.5, y = 0.65, 
             label = "Trust in AI Healthcare Decisions", 
             size = 16, fontface = "bold", 
             color = text_color, hjust = 0.5) +
    annotate("text", x = 0.5, y = 0.5, 
             label = "Dual Methodology with Sequential Updating", 
             size = 12, 
             color = secondary_color, hjust = 0.5) +
    annotate("text", x = 0.5, y = 0.35, 
             label = "A comprehensive statistical investigation using\nBayesian inference and uncertainty quantification", 
             size = 10, 
             color = text_color, hjust = 0.5) +
    annotate("text", x = 0.5, y = 0.15, 
             label = "Sam Koscelny | github.com/sam-kos41", 
             size = 9, 
             color = secondary_color, hjust = 0.5, fontface = "italic") +
    xlim(0, 1) + ylim(0, 1) +
    theme_void() +
    theme(panel.background = element_rect(fill = "white", color = NA))
  
  # Create methodology flowchart
  method_plot <- ggplot() +
    # Background boxes
    annotate("rect", xmin = 0.05, xmax = 0.95, ymin = 0.8, ymax = 0.95, 
             fill = primary_color, alpha = 0.1, color = primary_color, size = 1) +
    annotate("rect", xmin = 0.05, xmax = 0.45, ymin = 0.45, ymax = 0.75, 
             fill = secondary_color, alpha = 0.1, color = secondary_color, size = 1) +
    annotate("rect", xmin = 0.55, xmax = 0.95, ymin = 0.45, ymax = 0.75, 
             fill = accent_color, alpha = 0.1, color = accent_color, size = 1) +
    annotate("rect", xmin = 0.05, xmax = 0.95, ymin = 0.05, ymax = 0.35, 
             fill = light_gray, color = text_color, size = 1) +
    
    # Headers
    annotate("text", x = 0.5, y = 0.88, 
             label = "METHODOLOGY", 
             size = 12, fontface = "bold", color = primary_color, hjust = 0.5) +
    
    # Left box - Data
    annotate("text", x = 0.25, y = 0.68, 
             label = "DATA COLLECTION", 
             size = 10, fontface = "bold", color = secondary_color, hjust = 0.5) +
    annotate("text", x = 0.25, y = 0.58, 
             label = "• Healthcare AI Survey\n• Patient Trust Ratings\n• Multiple Scenarios", 
             size = 8, color = text_color, hjust = 0.5) +
    
    # Right box - Analysis
    annotate("text", x = 0.75, y = 0.68, 
             label = "BAYESIAN INFERENCE", 
             size = 10, fontface = "bold", color = accent_color, hjust = 0.5) +
    annotate("text", x = 0.75, y = 0.58, 
             label = "• Beta-Binomial Model\n• Prior Size Testing\n• HPD Intervals", 
             size = 8, color = text_color, hjust = 0.5) +
    
    # Bottom box - Results
    annotate("text", x = 0.5, y = 0.28, 
             label = "KEY FINDINGS", 
             size = 10, fontface = "bold", color = text_color, hjust = 0.5) +
    annotate("text", x = 0.5, y = 0.18, 
             label = "✓ Sequential updating improves accuracy  ✓ Uncertainty quantification critical\n✓ Prior size significantly impacts inference  ✓ Interactive visualization reveals patterns", 
             size = 8, color = text_color, hjust = 0.5) +
    
    # Arrows
    annotate("segment", x = 0.25, y = 0.45, xend = 0.75, yend = 0.45, 
             arrow = arrow(length = unit(0.3, "cm")), size = 1, color = text_color) +
    annotate("segment", x = 0.5, y = 0.45, xend = 0.5, yend = 0.35, 
             arrow = arrow(length = unit(0.3, "cm")), size = 1, color = text_color) +
    
    xlim(0, 1) + ylim(0, 1) +
    theme_void() +
    theme(panel.background = element_rect(fill = "white", color = NA))
  
  # Create sample visualization (mini beta distribution)
  theta <- seq(0, 1, length.out = 100)
  prior_data <- data.frame(
    theta = theta,
    density = dbeta(theta, 2, 5),
    type = "Prior"
  )
  posterior_data <- data.frame(
    theta = theta, 
    density = dbeta(theta, 12, 8),
    type = "Posterior"
  )
  
  viz_data <- rbind(prior_data, posterior_data)
  
  viz_plot <- ggplot(viz_data, aes(x = theta, y = density, color = type, linetype = type)) +
    geom_line(size = 1.5) +
    scale_color_manual(values = c("Prior" = secondary_color, "Posterior" = primary_color)) +
    scale_linetype_manual(values = c("Prior" = 2, "Posterior" = 1)) +
    labs(title = "Sample Bayesian Update",
         x = expression(theta), 
         y = "Density") +
    theme_minimal() +
    theme(
      plot.title = element_text(size = 11, hjust = 0.5, color = text_color, face = "bold"),
      legend.position = "bottom",
      legend.title = element_blank(),
      panel.background = element_rect(fill = "white", color = NA),
      plot.background = element_rect(fill = "white", color = NA),
      text = element_text(color = text_color)
    )
  
  # Create tech stack badges
  tech_plot <- ggplot() +
    # R badge
    annotate("rect", xmin = 0.1, xmax = 0.25, ymin = 0.4, ymax = 0.6, 
             fill = primary_color, color = "white", size = 1) +
    annotate("text", x = 0.175, y = 0.5, label = "R", 
             size = 8, color = "white", fontface = "bold") +
    
    # Bayesian badge  
    annotate("rect", xmin = 0.3, xmax = 0.5, ymin = 0.4, ymax = 0.6, 
             fill = secondary_color, color = "white", size = 1) +
    annotate("text", x = 0.4, y = 0.5, label = "BAYESIAN", 
             size = 6, color = "white", fontface = "bold") +
    
    # ggplot2 badge
    annotate("rect", xmin = 0.55, xmax = 0.75, ymin = 0.4, ymax = 0.6, 
             fill = accent_color, color = "white", size = 1) +
    annotate("text", x = 0.65, y = 0.5, label = "GGPLOT2", 
             size = 6, color = "white", fontface = "bold") +
    
    # Statistics badge
    annotate("rect", xmin = 0.8, xmax = 0.95, ymin = 0.4, ymax = 0.6, 
             fill = text_color, color = "white", size = 1) +
    annotate("text", x = 0.875, y = 0.5, label = "STATS", 
             size = 6, color = "white", fontface = "bold") +
    
    xlim(0, 1) + ylim(0, 1) +
    theme_void() +
    theme(panel.background = element_rect(fill = "white", color = NA))
  
  # Combine all plots
  combined_plot <- grid.arrange(
    title_plot,
    method_plot, 
    arrangeGrob(viz_plot, tech_plot, ncol = 2, widths = c(0.7, 0.3)),
    ncol = 1,
    heights = c(0.35, 0.45, 0.2)
  )
  
  return(combined_plot)
}

# Generate the cover
print("Creating project cover infographic...")
cover_plot <- create_project_cover()

# Save as high-quality PDF
ggsave("project_cover.pdf", plot = cover_plot, 
       width = 11, height = 8.5, dpi = 300, device = "pdf")

# Also save as PNG for web use
ggsave("project_cover.png", plot = cover_plot, 
       width = 11, height = 8.5, dpi = 300, device = "png", bg = "white")

print("✅ Project cover saved as 'project_cover.pdf' and 'project_cover.png'")
print("📁 Ready for portfolio use!")
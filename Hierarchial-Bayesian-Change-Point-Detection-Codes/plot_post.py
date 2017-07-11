# Source: https://github.com/aloctavodia/Doing_bayesian_data_analysis

# Function to plot posterior
import numpy as np
from scipy import stats
import matplotlib.pyplot as plt
from hpd import *

def plot_post(param_sample_vec, cred_mass = 0.95, comp_val = False, ROPE = False, ylab = '', xlab = 'Parameter', fontsize = 14, title = '', framealpha = 1, facecolor = 'skyblue', edgecolor = 'white', show_mode = True, bins = 50):
    
    # Calculate HDI
    HDI = hdp(param_sample_vec, 1 - cred_mass)
    
    posterior_summary = {'mean':0, 'median':0, 'hdi_mass':0,
                         'hdi_low':0, 'hdi_high':0, 'comp_val':0,
                         'pc_gt_comp_val':0, 'ROPE_low':0, 'ROPE_high':0,
                         'pc_in_ROPE':0}
    
    posterior_summary['mean'] = np.mean(param_sample_vec)
    posterior_summary['median'] = np.median(param_sample_vec)
    posterior_summary['mode'] = stats.mode(param_sample_vec)[0]
    posterior_summary['hdi_mass'] = cred_mass
    posterior_summary['hdi_low'] = HDI[0]
    posterior_summary['hdi_high'] = HDI[1]
    
    # Plot histogram
    n, bins, patches = plt.hist(param_sample_vec, normed = True, bins = bins, edgecolor = edgecolor, facecolor = facecolor)
    plt.xlabel(xlab, fontsize = fontsize)
    plt.ylabel(ylab, fontsize = fontsize)
    plt.title(title, fontsize = fontsize)
    
    cv_ht = 0.75 * np.max(n)
    cen_tend_ht = 0.9 * cv_ht
    ROPE_text_ht = 0.55 * cv_ht
    
    # Display mean or mode
    if show_mode:
        plt.plot(0, label = 'mode = %0.2f' % posterior_summary['mode'], alpha = 0)
    else:
        plt.plot(0, label = 'mean = %0.2f' % posterior_summary['mean'], alpha = 0)
    
     
    # Display comparison value
    if comp_val is not False:
        pc_gt_comp_val = 100 * np.sum(param_sample_vec > comp_val)/len(param_sample_vec)
        pc_lt_comp_val = 100 - pc_gt_comp_val
        
        plt.plot([comp_val, comp_val], [0, cv_ht], color = 'darkgreen', linestyle = '--', linewidth = 2, label = '%0.1f%% <%0.1f < %0.1f%%' % (pc_lt_comp_val, comp_val, pc_gt_comp_val))
        
        posterior_summary['comp_val'] = comp_val
        posterior_summary['pc_gt_comp_val'] = pc_gt_comp_val
        
        
    # Display the ROPE
    if ROPE is not False:
        rope_col = 'darkred'
        pc_in_ROPE = round(np.sum((param_sample_vec > ROPE[0]) & (param_sample_vec < ROPE[1]))/len(param_sample_vec) * 100)
        
        plt.plot([ROPE[0], ROPE[0]], [0, 0.96 * ROPE_text_ht], color = rope_col, linestyle = ':', linewidth = 4, label = '%0.1f%% in ROPE' % pc_in_ROPE)
        plt.plot([ROPE[1], ROPE[1]], [0, 0.96 * ROPE_text_ht], color = rope_col, linestyle = ':', linewidth = 4)
        
        posterior_summary['ROPE_low'] = ROPE[0] 
        posterior_summary['ROPE_high'] = ROPE[1] 
        posterior_summary['pc_in_ROPE'] = pc_in_ROPE
        
        
    # Display the HDI
    plt.plot(HDI, [0, 0], linewidth = 6, color = 'k', label = 'HDI %0.1f%% %0.3f-%0.3f' % (cred_mass*100, HDI[0], HDI[1]))
    plt.legend(loc = 'upper left', fontsize = fontsize, framealpha = framealpha)
    plt.title(title)
    
    
    return posterior_summary

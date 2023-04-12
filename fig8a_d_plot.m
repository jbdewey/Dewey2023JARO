%% Plot Fig 8A-D from Dewey and Shera (2023) JARO
close all;clear;clc;
load Dewey_2023_JARO_figs.mat

panels = [{'a'};{'b'};{'c'};{'d'}]; % panel letters
panelN = length(panels);
locs = [{'BM'};{'OHC'};{'TM'};{'EC'}]; % measurement locations
clrs = [{[28 82 172]/255}; {[237 118 194]/255}; {[255 148 0]/255}; {'r'}]; % plot colors
lws = [1.3 1.6 1.9 2.2 2.5 2.8 4.2]; % line widths

% Plot each panel
for p_i = 1:panelN
    panel = panels{p_i};
    loc = locs{p_i}; % location
    clr = clrs{p_i}; % color
    
    if strcmp(loc,'EC')
        recType = 'mic';
    else
        recType = 'vib';
    end
    
    % Get data
    fdps = 2*fig8.(genvarname(panel)).(genvarname(loc)).f1s - fig8.(genvarname(panel)).(genvarname(loc)).f2s; % DP frequency (Hz)
    L1s = fig8.(genvarname(panel)).(genvarname(loc)).L1s; % f1 level (dB SPL)
    L1N = length(L1s);

    f1_mag = fig8.(genvarname(panel)).(genvarname(loc)).(genvarname(recType)).f1.mag; % f1 response magnitude (nm or Pa RMS)
    f1_magC = fig8.(genvarname(panel)).(genvarname(loc)).(genvarname(recType)).f1.magC; % Clean f1 response magnitude

    f2_mag = fig8.(genvarname(panel)).(genvarname(loc)).(genvarname(recType)).f2.mag; % f2 response magnitude
    f2_magC = fig8.(genvarname(panel)).(genvarname(loc)).(genvarname(recType)).f2.magC; % Clean f2 response magnitude

    dp_mag = fig8.(genvarname(panel)).(genvarname(loc)).(genvarname(recType)).dp.mag; % DP response magnitude
    dp_magC = fig8.(genvarname(panel)).(genvarname(loc)).(genvarname(recType)).dp.magC; % Clean DP response magnitude
    dp_phi = fig8.(genvarname(panel)).(genvarname(loc)).(genvarname(recType)).dp.phi; % DP response phase (cycles)
    dp_phiC = fig8.(genvarname(panel)).(genvarname(loc)).(genvarname(recType)).dp.phiC; % Clean DP response phase
   
    % Set up figure
    h = figure('units','normalized','position',[.1+(p_i-1)/4.5 .1 .15 .75]);
    ax1 = axes('position', [.15 .71 .8 .15],'FontSize',15,'LineWidth', 1.4, 'box','off'); hold on;
    ax2 = axes('position', [.15 .54 .8 .15],'FontSize',15,'LineWidth', 1.4, 'box','off'); hold on;
    ax3 = axes('position', [.15 .34 .8 .182],'FontSize',15,'LineWidth', 1.4, 'box','off'); hold on;
    ax4 = axes('position', [.15 .17 .8 .15],'FontSize',15,'LineWidth', 1.4, 'box','off'); hold on;

    axes(ax1); % f2 mag
    xlim([1 9]); set(gca,'Xscale','log','Xtick',[1 2 5 9]);
    ax1.XAxis.Visible = 'off';

    if strcmp(loc,'EC')
        ylim([37 83])
    else
        ylim([-16 30]);
    end

    set(gca,'Ytick',-100:20:100);
    ax1.YAxis.MinorTick = 'on';
    ax1.YAxis.MinorTickValues = -100:10:100;
    ax1.YAxis.TickLength = [.02 .02];

    if p_i<4 && p_i>1
        set(gca,'YTickLabels',' ');
    end

    % Ratio axis
    pos = get(ax1,'position');
    pos(2) = pos(2) + .01;
    ax6 = axes('position',pos, 'box','off','LineWidth', 1.4, 'FontSize', 15,'Color','none','XAxisLocation', 'top','Color', 'none'); hold on;
    ax6.XAxis.TickLength = [.015 .015];  
    xlim([1 9]); set(gca,'Xscale','log','TickDir','out','Xtick',[1	2.25	3.857142857	6	9],'XMinorTick','off','XTickLabels',[])
    ax6.YAxis.Visible = 'off';
    ax6.XAxis.MinorTick = 'on';
    ax6.XAxis.MinorTickValues = [1 1.59 2.25 3 3.86 4.85 6 7.36 9];

    axes(ax2); % f1 mag
    xlim([1 9]);  set(gca,'Xscale','log','Xtick',[1 2 5 9]);
    ax2.XAxis.Visible = 'off';
    
    if strcmp(loc,'EC')
        ylim([37 83])
    else
        ylim([-16 30]);
    end

    set(gca,'Ytick',-100:20:100);
    ax2.YAxis.MinorTick = 'on';
    ax2.YAxis.MinorTickValues = -100:10:100;
    ax2.YAxis.TickLength = [.02 .02];

    if p_i<4 && p_i>1
        set(gca,'YTickLabels',' ');
    end
    
    axes(ax3); % DP mag
    xlim([1 9]); set(gca,'Xscale','log','Xtick',[1 2 5 9]);
    ax3.XAxis.Visible = 'off';

    if strcmp(loc,'EC')
        ylim([-14 40]);
    else
        ylim([-41 13]);
    end

    set(gca,'Ytick',-100:20:100);
    ax3.YAxis.MinorTick = 'on';
    ax3.YAxis.MinorTickValues = -100:10:100;
    ax3.YAxis.TickLength = [.02 .02];

    if p_i<4 && p_i>1
        set(gca,'YTickLabels',' ');
    end
    
    axes(ax4); % DP phase
    xlim([1 9]); set(gca,'Xscale','log','Xtick',[1 2 5 9]);
    ax4.XAxis.Visible = 'off';
    ylim([-5 0.5]); set(gca,'Ytick',-6:2:2);
    ax4.YAxis.MinorTick = 'on';
    ax4.YAxis.MinorTickValues = -8:1:2;
    ax4.YAxis.TickLength = [.02 .02];

    if p_i<4 && p_i>1
        set(gca,'YTickLabels',' ');
    end
    
    % X-axis
    pos = get(ax4,'position');
    pos(2) = pos(2) - .01;
    ax5 = axes('position',pos, 'box','off','LineWidth', 1.4, 'FontSize', 15,'Color','none'); hold on;
    ax5.XAxis.TickLength = [.015 .015];
    xlim([1 9]); 
    set(gca,'Xscale','log','Xtick',[1 2 5 9]);
    ax5.XAxis.MinorTick = 'on';
    ax5.YAxis.Visible = 'off';        

    % Plot data for each level
    for L1_i = [1 3 4 5 7]
        L1 = L1s(L1_i); % stimulus level
        lw = lws(L1_i); % line width

        if isequal(L1,60)
            lsty = '--'; % line style
        else
            lsty = '-';
        end

        if strcmp(loc, 'EC') % Ear canal
            
            axes(ax1); % f2 mag
            plot(fdps/1000, 20*log10(f2_magC(:,L1_i)/2e-5), 'LineStyle', lsty, 'LineWidth', lw, 'Color', 'k');
            
            axes(ax2); % f1 mag
            plot(fdps/1000, 20*log10(f1_magC(:,L1_i)/2e-5), 'LineStyle', lsty, 'LineWidth', lw, 'Color', [.7 .7 .7]);
            
            axes(ax3); % DP mag
            plot(fdps/1000, 20*log10(dp_magC(:,L1_i)/2e-5), 'LineStyle', lsty, 'LineWidth', lw, 'Color', clr);
            
            axes(ax4); % DP phase
            plot(fdps/1000, dp_phiC(:,L1_i), 'LineStyle', lsty, 'LineWidth', lw, 'Color', clr);

        else % Vibration
            
            axes(ax1); % f2 mag
            plot(fdps/1000, 20*log10(f2_magC(:,L1_i)), 'LineStyle', lsty, 'LineWidth', lw, 'Color', 'k');
            
            axes(ax2); % f1 mag
            plot(fdps/1000, 20*log10(f1_magC(:,L1_i)), 'LineStyle', lsty, 'LineWidth', lw, 'Color', [.7 .7 .7]);
            
            axes(ax3); % DP mag
            if L1==55 && strcmp(loc,'TM')
                plot(fdps(fdps>4000)/1000, 20*log10(dp_mag(fdps>4000,L1_i)), ':', 'LineWidth', 1.8, 'Color', clr);
            end
            if L1==45 && strcmp(loc,'OHC')
                plot(fdps(fdps>4000)/1000, 20*log10(dp_mag(fdps>4000,L1_i)), ':', 'LineWidth', 1.8, 'Color', clr);
            end
            
            plot(fdps/1000, 20*log10(dp_magC(:,L1_i)), 'LineStyle', lsty, 'LineWidth', lw, 'Color', clr);
            
            axes(ax4); % DP phase
            if L1 == 55 && strcmp(loc,'TM')
               plot(fdps(fdps>4000)/1000, dp_phi(fdps>4000,L1_i), ':', 'LineWidth', 1.8, 'Color', clr);
            end
            if L1 == 45 && strcmp(loc,'OHC')
               plot(fdps(fdps>4000)/1000, dp_phi(fdps>4000,L1_i), ':', 'LineWidth', 1.8, 'Color', clr);
            end

            plot(fdps/1000, dp_phiC(:,L1_i), '-', 'LineWidth', lw, 'Color', clr);
        end
    end
end
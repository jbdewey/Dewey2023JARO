%% Plot Fig 2A-D from Dewey and Shera (2023) JARO
close all;clear;clc;
load Dewey_2023_JARO_figs.mat

panels = [{'a'};{'b'};{'c'};{'d'}]; % panel letters
panelN = length(panels);
locs = [{'BM'};{'OHC'};{'TM'};{'EC'}]; % measurement locations
clrs = [{[28 82 172]/255}; {[237 118 194]/255}; {[255 148 0]/255}; {'r'}]; % plot colors

% Plot each panel
for p_i = 1:panelN
    p = panels{p_i};
    loc = locs{p_i};
    clr = clrs{p_i};
    
    if p_i < 4
        % Fig. 2A-C - Single-tone BM, OHC, and TM responses for mouse 'm101'

        f1s = fig2.(genvarname(p)).(genvarname(loc)).f1s;
        L1s = fig2.(genvarname(p)).(genvarname(loc)).L1s;
        magC = fig2.(genvarname(p)).(genvarname(loc)).vib.f1.magC;
        phiC = fig2.(genvarname(p)).(genvarname(loc)).vib.f1.phiC;

        xlims = [.98 15];

        % Set up figure
        h=figure('units','normalized','position',[.1 .1 .18 .4]);
        ax1 = axes('position',[.18 .42 .7 .5], 'box', 'off','LineWidth',1.4, 'FontSize',15); hold on;
        ax2 = axes('position',[.18 .12 .7 .28], 'box', 'off','LineWidth', 1.4, 'FontSize', 15); hold on;

        axes(ax1); % Magnitude (dB re 1 nm RMS)
        xlim(xlims); 
        set(gca,'Xscale','log','Xtick',[1 2 5 10 20 50],'XtickLabels',' ');
        ax1.XAxis.Visible = 'off';
        
        ylim([-30.5 29.5]); 
        set(gca,'Ytick',-100:20:100);
        ax1.YAxis.MinorTick = 'on';
        ax1.YAxis.MinorTickValues = -100:10:100;
        ax1.YAxis.TickLength = [0.02 0.02];
        
        if p_i > 1
            set(gca,'YTickLabels', ' ');
        end

        axes(ax2); % Phase (cycles)
        xlim(xlims); 
        set(gca,'Xscale','log','Xtick',[1 2 5 10 20 50]);
        ax2.XAxis.TickLength = [0.02 0.02];

        ylim([-5.5 0]);  
        set(gca,'Ytick',-10:2:10);
        ax2.YAxis.MinorTick = 'on';
        ax2.YAxis.MinorTickValues = -10:1:10;
        ax2.YAxis.TickLength = [0.02 0.02];

        if p_i > 1
            set(gca,'YTickLabels', ' ');
        end

        % Plot
        for L_i=length(L1s):-1:1
            L1 = L1s(L_i);
            lw = 0.35+L_i*0.35; % line width
            
            axes(ax1); % Magnitude (dB re 1 nm)
            plot(f1s/1000, 20*log10(magC(:,L_i)), '-', 'LineWidth',lw, 'Color', clr);

            axes(ax2); % Phase (cycles)
            plot(f1s/1000, phiC(:, L_i), '-','LineWidth',lw, 'Color',clr);
        end

    else  
        % Fig. 2D - DPOAE amplitude and phase for mouse 'm101'
        
        L1s = fig2.(genvarname(p)).(genvarname(loc)).L1s;
        f1s = fig2.(genvarname(p)).(genvarname(loc)).f1s;
        f2s = fig2.(genvarname(p)).(genvarname(loc)).f2s;
        fdps = 2*f1s-f2s;
        f2f1ratios = f2s./f1s;

        magC = fig2.(genvarname(p)).(genvarname(loc)).mic.dp.magC;
        phiC = fig2.(genvarname(p)).(genvarname(loc)).mic.dp.phiC;

        xlims=[1.4 9];

        % Set up figure
        h=figure('units','normalized','position',[.1 .1 .18 .4]);
        ax1 = axes('position',[.18 .42 .7 .4375], 'box', 'off','LineWidth',1.4, 'FontSize', 15); hold on;
        ax2 = axes('position',[.18 .12 .7 .28], 'box', 'off','LineWidth', 1.4, 'FontSize', 15); hold on;

        axes(ax1); % DPOAE amplitude (dB SPL)
        xlim(xlims); set(gca,'Xscale','log','Xtick',[1 2 5 9],'XtickLabels',' ');
        ax1.XAxis.TickLength = [0.02 0.02];
        ax1.XAxis.Visible = 'off';

        ylim([-15 37.5]); set(gca,'Ytick',-100:20:100);
        ax1.YAxis.MinorTick = 'on';
        ax1.YAxis.MinorTickValues = -100:10:100;
        ax1.YAxis.TickLength = [0.02 0.02];

        axes(ax2); % DPOAE phase (cycles)
        xlim(xlims); set(gca,'Xscale','log','Xtick',[1 2 5 9]);
        ax2.XAxis.TickLength = [0.02 0.02];
        ax2.XAxis.TickLength = [0.02 0.02];

        ylim([-5.5 0]); set(gca,'Ytick',-10:2:10);
        ax2.YAxis.MinorTick = 'on';
        ax2.YAxis.MinorTickValues = -10:1:10;
        ax2.YAxis.TickLength = [0.02 0.02];

        % Ratio axis
        f2f1ax_pos = ax1.Position;
        f2f1ax_pos(2) = f2f1ax_pos(2) + .02;
        
        f2f1ax = axes('Position',f2f1ax_pos, 'box','off', 'LineWidth', 1.4, 'FontSize', 12, 'XAxisLocation', 'top','Color', 'none'); hold on;
        f2f1ax.YAxis.Visible = 'off';
        f2f1ax.XAxis.TickLength = [.015 .015];
        xlim(xlims);

        set(gca,'Xscale','log','TickDir','out','Xtick',[1 2.25 3.86 6 9],'XMinorTick','off','XTickLabels',[]);
        f2f1ax.XAxis.MinorTick = 'on';
        f2f1ax.XAxis.MinorTickValues = [1 1.59 2.25 3 3.86 4.85 6 7.36 9];
        
        % Plot
        for L_i=length(L1s):-1:1
            lw = 0.35+L_i*0.35; % line width
            axes(ax1); % Magnitude (dB SPL)
            plot(fdps/1000, 20*log10(magC(:,L_i)/2e-5), '-', 'LineWidth',lw, 'Color', clr);
            
            axes(ax2); % Phase (cycles)
            plot(fdps/1000, phiC(:, L_i), '-','LineWidth',lw, 'Color',clr);
        end
    end    
end
